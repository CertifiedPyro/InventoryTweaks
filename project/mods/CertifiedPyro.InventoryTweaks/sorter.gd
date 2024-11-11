extends Control


const item_order := PoolStringArray([
	# Item_Tools (gambling)
	"scratch_off",
	"scratch_off_2",
	"scratch_off_3",
	# Item_Tools (placeable fishing props)
	"fish_trap",
	"fish_trap_ocean",
	"portable_bait",
	# Item_Tools (catches from fishing)
	"treasure_chest",
	# Item_Consumables
	"potion_catch",
	"potion_catch_big",
	"potion_catch_deluxe",
	"potion_speed",
	"potion_speed_burst",
	"potion_beer",
	"potion_wine",
	"potion_revert",
	"potion_small",
	"potion_grow",
	"potion_bounce",
	"potion_bouncebig",
	# Item_Tools (fishing rods)
	"fishing_rod_simple",
	"fishing_rod_travelers",
	"fishing_rod_skeleton",  # Spectral rod before collector's rods
	"fishing_rod_collectors",
	"fishing_rod_collectors_shining",
	"fishing_rod_collectors_glistening",
	"fishing_rod_collectors_opulent",
	"fishing_rod_collectors_radiant",
	"fishing_rod_collectors_alpha",
	"fishing_rod_prosperous",
	# Item_Tools (dock shop)
	"metal_detector",
	# Item_Tools (misc in general store)
	"boxing_glove",
	"boxing_glove_super",
	"hand_labeler",
	"ringbox",
	# Item_Chalk
	"chalk_eraser",  # Out of order from store order, but more convenient
	"chalk_white",
	"chalk_black",
	"chalk_red",
	"chalk_blue",
	"chalk_yellow",
	"chalk_green",
	"chalk_special",
	# Item_Tools (instruments)
	"guitar",
	"guitar_gradient",
	"guitar_stickers",
	"guitar_black",
	"guitar_pink",
	"guitar_gold",
	"tambourine"
])

# Dictionary of item name to its index in the desired sort order.
var item_order_idx_dict := {}


func _ready() -> void:
	PlayerData.connect("_inventory_refresh", self, "_sort_inventory")
	
	for i in range(item_order.size()):
		item_order_idx_dict[item_order[i]] = i
	
	_sort_inventory()


func _on_visibility_changed() -> void:
	_sort_inventory()


func _sort_inventory() -> void:
	var custom_sorter = CustomSorter.new(item_order_idx_dict)
	
	# Sort inventory according to desired order in item_order 
	var sorted_inventory := PlayerData.inventory.duplicate(true) as Array
	sorted_inventory.sort_custom(custom_sorter, "sort")
	
	# Deduplicate items with the same id and ref
	# This fixes the "infinite beer" glitch
	var new_inventory := []
	var item_id := ""
	var items := []
	for item in sorted_inventory:
		if item["id"] != item_id:
			item_id = item["id"]
			items = [item]
			new_inventory.append(item)
			continue
		
		# Try to find duplicate ref
		var found_item = null
		for search_item in items:
			if item["ref"] == search_item["ref"]:
				found_item = search_item
				break
		
		# If duplicate ref found, add count to existing item
		if found_item != null:
			found_item["count"] += item["count"]
		else:
			new_inventory.append(item)
	
	PlayerData.inventory = new_inventory


class CustomSorter:
	const NOT_FOUND_IDX = 100_000
	var item_order_idx_dict: Dictionary
	
	func _init(item_order_idx_dict_arg: Dictionary):
		item_order_idx_dict = item_order_idx_dict_arg
	
	func sort(a: Dictionary, b: Dictionary):
		# Keep favorites at beginning of inventory.
		var is_a_favorited = PlayerData.locked_refs.has(a["ref"])
		var is_b_favorited = PlayerData.locked_refs.has(b["ref"])
		if is_a_favorited and not is_b_favorited:
			return true
		if not is_a_favorited and is_b_favorited:
			return false
		
		var a_idx := item_order_idx_dict.get(a["id"], NOT_FOUND_IDX) as int
		var b_idx := item_order_idx_dict.get(b["id"], NOT_FOUND_IDX) as int
		if a_idx == NOT_FOUND_IDX and b_idx == NOT_FOUND_IDX:
			# If both items are unknown, just sort by item's id string
			return a["id"] < b["id"]
		if a_idx != b_idx:
			# Sort based on index in item_order
			return a_idx < b_idx
		
		# Sort based on count
		var a_count := a.get("count", 1) as int
		var b_count := b.get("count", 1) as int
		return a_count > b_count

extends Control
# Implements modded inventory behavior:
# - Sorts inventory and stacks some previously unstackable items (e.g. treasure chests)
# - Allow keyboard navigation of submenus with Q and E keys


const MAIN_THEME := preload("res://Assets/Themes/main.tres")

const ITEM_ORDER := PoolStringArray([
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
	"chalk_eraser",
	"chalk_red",
	"chalk_yellow",
	"chalk_green",
	"chalk_blue",
	"chalk_white",
	"chalk_black",
	"chalk_special",
	# Item_Tools (instruments)
	"guitar",
	"guitar_gradient",
	"guitar_stickers",
	"guitar_black",
	"guitar_pink",
	"guitar_gold",
	"tambourine",
	# Prop_Items
	"prop_island_tiny",
	"prop_island_med",
	"prop_island_big",
	# Creatures_MetalDetectLoot (pieces)
	"mdl_piece_hat",
	"mdl_piece_monocle",
	"mdl_piece_sword",
	"mdl_piece_watch",
	# Creatures_MetalDetectLoot (junk)
	"mdl_button",
	"mdl_casing",
	"mdl_coin",
	"mdl_ring",
	"mdl_sodatab"
])
const HOTKEY_LABEL_GROUP = "cpit_inventory_hotkey_label"

# Dictionary of item name to its index in the desired sort order.
var item_order_idx_dict := {}
var inventory_tabs := []

var first_hotkey_label_template: Button
var last_hotkey_label_template: Button

onready var inventory_tabs_node := get_parent().get_node("tabs")


func _ready() -> void:
	for i in range(ITEM_ORDER.size()):
		item_order_idx_dict[ITEM_ORDER[i]] = i
	_sort_inventory()
	_create_hotkey_label_templates()


func _unhandled_key_input(event: InputEventKey) -> void:
	if inventory_tabs_node == null:
		return
	
	if not is_visible_in_tree():
		return
	
	if not event.is_action_pressed("tab_next") and not event.is_action_pressed("tab_prev"):
		return
	
	# Get active tab by checking which button is disabled.
	_get_inventory_tabs()
	var num_tabs := inventory_tabs.size()
	var active_idx := -1
	for i in range(num_tabs):
		var tab := inventory_tabs[i] as Button
		if tab.disabled:
			active_idx = i
			break
	
	if active_idx == -1:
		return
	
	# Set new active tab based on action taken.
	if event.is_action_pressed("tab_next"):
		active_idx += 1
	elif event.is_action_pressed("tab_prev"):
		active_idx -= 1
	active_idx = posmod(active_idx, num_tabs)
	
	# Initiate press on the new active tab.
	(inventory_tabs[active_idx] as Button).emit_signal("pressed")


func _on_visibility_changed() -> void:
	if not self.is_visible_in_tree():
		return
	
	# Sort inventory.
	_sort_inventory()
	PlayerData.emit_signal("_inventory_refresh")
	
	if inventory_tabs_node == null:
		return
	
	# Remove old hotkey labels.
	var old_hotkey_labels := get_tree().get_nodes_in_group(HOTKEY_LABEL_GROUP)
	for i in range(old_hotkey_labels.size()):
		(old_hotkey_labels[i] as Node).queue_free()
	
	_get_inventory_tabs()
	
	# Add new hotkey labels to first and last journal buttons.
	var first_label = first_hotkey_label_template.duplicate()
	(inventory_tabs[0] as Node).add_child(first_label)
	first_label.add_to_group(HOTKEY_LABEL_GROUP)

	var last_label = last_hotkey_label_template.duplicate()
	(inventory_tabs[-1] as Node).add_child(last_label)
	last_label.add_to_group(HOTKEY_LABEL_GROUP)


func _sort_inventory() -> void:
	var custom_sorter = CustomSorter.new(item_order_idx_dict)
	
	# Sort inventory according to desired order in item_order.
	var sorted_inventory := PlayerData.inventory.duplicate(true) as Array
	sorted_inventory.sort_custom(custom_sorter, "sort")
	
	# Deduplicate items with the same id and ref, which fixes the "infinite beer" glitch.
	# Also dedup treasure chests.
	var new_inventory := []
	var item_id := ""
	var items := []
	for item in sorted_inventory:
		if item["id"] != item_id:
			item_id = item["id"]
			items = [item]
			new_inventory.append(item)
			continue
		
		# Try to find duplicate refs and treasure chests.
		var found_item = null
		for search_item in items:
			if item["ref"] == search_item["ref"] or item["id"] == "treasure_chest":
				found_item = search_item
				break
		
		# If duplicate found, add count to existing item
		if found_item != null:
			found_item["count"] += item["count"]
		else:
			new_inventory.append(item)
	
	PlayerData.inventory = new_inventory


func _get_inventory_tabs() -> void:
	inventory_tabs = []
	for node in inventory_tabs_node.get_children():
		if node is Button:
			inventory_tabs.append(node)


func _create_hotkey_label_templates() -> void:
	# Create a disabled button that shows the hotkey used to switch between tabs.
	var hotkey_label := Button.new()
	hotkey_label.anchor_left = 1
	hotkey_label.anchor_right = 1
	hotkey_label.margin_top = 6
	hotkey_label.margin_right = -12
	hotkey_label.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	hotkey_label.rect_min_size = Vector2(32, 0)
	hotkey_label.rect_scale = Vector2(0.75, 0.75)
	hotkey_label.disabled = true
	hotkey_label.theme = MAIN_THEME
	hotkey_label.add_stylebox_override("disabled", hotkey_label.get_stylebox("normal"))
	
	# Create hotkey label for first submenu button.
	first_hotkey_label_template = hotkey_label.duplicate() as Button
	var prev_action := InputMap.get_action_list("tab_prev")[0] as InputEvent
	first_hotkey_label_template.text = prev_action.as_text()
	
	# Create hotkey label for last submenu button.
	last_hotkey_label_template = hotkey_label.duplicate() as Button
	var next_action := InputMap.get_action_list("tab_next")[0] as InputEvent
	last_hotkey_label_template.text = next_action.as_text()


class CustomSorter:
	const NOT_FOUND_IDX = 100_000
	var item_order_idx_dict: Dictionary
	
	func _init(item_order_idx_dict_arg: Dictionary) -> void:
		item_order_idx_dict = item_order_idx_dict_arg
	
	func sort(a: Dictionary, b: Dictionary) -> bool:
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
			# If both items are unknown, just sort by item name
			var a_item_name := self._get_item_name(a).to_lower()
			var b_item_name := self._get_item_name(b).to_lower()
			return a_item_name < b_item_name

		if a_idx != b_idx:
			# Sort based on index in item_order
			return a_idx < b_idx
		
		# Sort based on count
		var a_count := a.get("count", 1) as int
		var b_count := b.get("count", 1) as int
		return a_count > b_count
	
	
	# Copied partially from PlayerData._get_item_name()
	func _get_item_name(item: Dictionary) -> String:
		var item_name = Globals.item_data[item["id"]]["file"].item_name
		return item_name

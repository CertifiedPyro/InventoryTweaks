extends Control
# Implements modded inventory behavior:
# - Sorts inventory and stacks some previously unstackable items (e.g. treasure chests)
# - Allow keyboard navigation of submenus with Q and E keys
# - Allow keyboard navigation of pages with Z and C keys


const Constants := preload("res://mods/CertifiedPyro.InventoryTweaks/InventoryModded/inventory_constants.gd")
const CpitUtils := preload("res://mods/CertifiedPyro.InventoryTweaks/utils.gd")
const Inventory := preload("res://Scenes/HUD/inventory.gd")
const MAIN_THEME := preload("res://Assets/Themes/main.tres")

const HOTKEY_LABEL_GROUP = "cpit_inventory_hotkey_label"

var first_hotkey_label_template: Button
var last_hotkey_label_template: Button

# Dictionary of item name to its index in the desired sort order.
var item_order_idx_dict := {}
var inventory_tabs := []

onready var inventory_node := get_parent() as Inventory
onready var inventory_tabs_node := get_parent().get_node("tabs")
onready var pages_node := get_parent().get_node("Panel/HBoxContainer")


func _ready() -> void:
	for i in range(Constants.ITEM_ORDER.size()):
		item_order_idx_dict[Constants.ITEM_ORDER[i]] = i
	
	_sort_inventory()
	_create_hotkey_label_templates()
	_add_page_labels()


func _unhandled_key_input(event: InputEventKey) -> void:
	if not is_visible_in_tree():
		return
	
	if event.is_action_pressed("tab_next") or event.is_action_pressed("tab_prev"):
		_handle_tab_event(event)
	
	if event.is_action_pressed("page_prev") or event.is_action_pressed("page_next"):
		_handle_page_event(event)


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


func _handle_tab_event(event: InputEventKey) -> void:
	if inventory_tabs_node == null:
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


func _handle_page_event(event: InputEventKey) -> void:
	if inventory_node == null:
		return
	
	if event.is_action_pressed("page_prev"):
		inventory_node._prev_page()
	elif event.is_action_pressed("page_next"):
		inventory_node._next_page()


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
	first_hotkey_label_template.text = CpitUtils.get_key_from_action("tab_prev")
	
	# Create hotkey label for last submenu button.
	last_hotkey_label_template = hotkey_label.duplicate() as Button
	last_hotkey_label_template.text = CpitUtils.get_key_from_action("tab_next")

func _add_page_labels() -> void:
	if pages_node == null:
		return
	
	var page_prev_label := Label.new()
	page_prev_label.text = CpitUtils.get_key_from_action("page_prev") + " "
	page_prev_label.align = Label.ALIGN_CENTER
	pages_node.add_child(page_prev_label)
	pages_node.move_child(page_prev_label, 0)
	
	var page_next_label := Label.new()
	page_next_label.text = " " + CpitUtils.get_key_from_action("page_next")
	page_next_label.align = Label.ALIGN_CENTER
	pages_node.add_child(page_next_label)


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

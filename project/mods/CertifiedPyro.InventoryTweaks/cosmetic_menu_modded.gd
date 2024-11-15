extends Control


const CosmeticMenu := preload("res://Scenes/HUD/CosmeticMenu/cosmetic_menu.gd")
const MAIN_THEME := preload("res://Assets/Themes/main.tres")

const HOTKEY_LABEL_GROUP = "cpit_cosmetic_menu_hotkey_label"

var cosmetic_tabs := []
var first_hotkey_label_template: Button
var last_hotkey_label_template: Button

onready var cosmetic_menu := get_parent() as CosmeticMenu
onready var cosmetic_tabs_node := get_parent().get_node("HBoxContainer")


func _ready() -> void:
	_create_hotkey_label_templates()


func _unhandled_key_input(event: InputEventKey) -> void:
	if cosmetic_menu == null or cosmetic_tabs_node == null:
		return

	if not is_visible_in_tree():
		return

	if not event.is_action_pressed("tab_next") and not event.is_action_pressed("tab_prev"):
		return
	
	# Get active tab.
	_get_cosmetic_tabs()
	var num_tabs := cosmetic_tabs.size()
	var active_idx := -1
	for i in range(num_tabs):
		var tab := cosmetic_tabs[i] as Button
		print(tab.name + ", " + cosmetic_menu.category)
		if tab.name == cosmetic_menu.category:
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
	(cosmetic_tabs[active_idx] as Button).emit_signal("pressed")


func _on_visibility_changed() -> void:
	if cosmetic_tabs_node == null:
		return
	
	if not is_visible_in_tree():
		return
	
	# Remove old hotkey labels.
	var old_hotkey_labels := get_tree().get_nodes_in_group(HOTKEY_LABEL_GROUP)
	for i in range(old_hotkey_labels.size()):
		(old_hotkey_labels[i] as Node).queue_free()
	
	_get_cosmetic_tabs()

	# Add new hotkey labels to first and last journal buttons.
	var first_label := first_hotkey_label_template.duplicate()
	(cosmetic_tabs[0] as Node).add_child(first_label)
	first_label.add_to_group(HOTKEY_LABEL_GROUP)

	var last_label := last_hotkey_label_template.duplicate()
	(cosmetic_tabs[-1] as Node).add_child(last_label)
	last_label.add_to_group(HOTKEY_LABEL_GROUP)


func _get_cosmetic_tabs() -> void:
	cosmetic_tabs = []
	for node in cosmetic_tabs_node.get_children():
		if node is Button:
			cosmetic_tabs.append(node)


func _create_hotkey_label_templates() -> void:
	# Create a disabled button that shows the hotkey used to switch between tabs.
	var hotkey_label := Button.new()
	hotkey_label.anchor_top = 0.5
	hotkey_label.anchor_bottom = 0.5
	hotkey_label.grow_vertical = Control.GROW_DIRECTION_BOTH
	hotkey_label.rect_min_size = Vector2(32, 32)
	hotkey_label.rect_pivot_offset = hotkey_label.rect_size / 2
	hotkey_label.rect_scale = Vector2(0.75, 0.75)
	hotkey_label.disabled = true
	hotkey_label.theme = MAIN_THEME
	
	# Create hotkey label for first submenu button.
	first_hotkey_label_template = hotkey_label.duplicate() as Button
	first_hotkey_label_template.margin_left = 8
	
	var prev_action := InputMap.get_action_list("tab_prev")[0] as InputEvent
	first_hotkey_label_template.text = prev_action.as_text()

	# Create hotkey label for last submenu button.
	last_hotkey_label_template = hotkey_label.duplicate() as Button
	last_hotkey_label_template.anchor_left = 1
	last_hotkey_label_template.anchor_right = 1
	last_hotkey_label_template.margin_right = -8
	last_hotkey_label_template.grow_horizontal = Control.GROW_DIRECTION_BEGIN
	
	var next_action := InputMap.get_action_list("tab_next")[0] as InputEvent
	last_hotkey_label_template.text = next_action.as_text()

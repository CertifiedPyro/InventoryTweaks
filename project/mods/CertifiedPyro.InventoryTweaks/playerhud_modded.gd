extends Control


const PlayerHud := preload("res://Scenes/HUD/playerhud.gd")
const MAIN_THEME := preload("res://Assets/Themes/main.tres")

onready var player_hud := $"/root/playerhud" as PlayerHud
onready var menu_buttons := get_parent().get_node("buttons") as Control


func _ready() -> void:
	if player_hud == null or menu_buttons == null:
		return
	
	# Create a disabled button that shows the hotkey used to activate the menu botton.
	var hotkey_label_template := Button.new()
	hotkey_label_template.anchor_top = 1
	hotkey_label_template.anchor_left = 0.5
	hotkey_label_template.anchor_right = 0.5
	hotkey_label_template.margin_top = 16
	hotkey_label_template.grow_horizontal = Control.GROW_DIRECTION_BOTH
	hotkey_label_template.rect_min_size = Vector2(32, 0)
	hotkey_label_template.disabled = true
	hotkey_label_template.theme = MAIN_THEME
	hotkey_label_template.add_stylebox_override("disabled", hotkey_label_template.get_stylebox("normal"))
	
	# Modify the buttons at the top of the menu (inventory, creatures, cosmetics, etc).
	for i in menu_buttons.get_child_count():
		var node := menu_buttons.get_child(i) as Control
		var hotkey_label := hotkey_label_template.duplicate()
		hotkey_label.text = str(i + 1)
		node.add_child(hotkey_label)


func _unhandled_key_input(event: InputEventKey) -> void:
	if player_hud == null:
		return
	
	if not self.is_visible_in_tree():
		return
	
	if event.is_action_pressed("tab_next") or event.is_action_pressed("tab_prev"):
		_handle_tab_change()
	
	if (
			not event.is_action_pressed("bind_1")
			and not event.is_action_pressed("bind_2")
			and not event.is_action_pressed("bind_3")
			and not event.is_action_pressed("bind_4")
			and not event.is_action_pressed("bind_5")
	):
		return
	
	# Wait for inventory.gd to assign item to hotbar, if applicable.
	# We wait for 2 frames, because we're waiting until _process() in inventory.gd is ran.
	# However, the idle_frame signal is triggered before _process() is ran.
	var old_hotbar := (PlayerData.hotbar as Dictionary).duplicate()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
#
	# Check if hotbar items changed.
	# If yes, the keys were used for that, so don't switch tabs.
	var current_hotbar := (PlayerData.hotbar as Dictionary).duplicate()
	if old_hotbar.hash() != current_hotbar.hash():
		return
	
	# Switch to the correct tab based on the keybind pressed.
	var new_tab = 0
	if event.is_action_pressed("bind_2"):
		new_tab = 1
	elif event.is_action_pressed("bind_3"):
		new_tab = 2
	elif event.is_action_pressed("bind_4"):
		new_tab = 3
	elif event.is_action_pressed("bind_5"):
		new_tab = 4
	
	player_hud._change_tab(new_tab)


func _handle_tab_change():
	# Disable the _process() loop in playerhud.gd temporarily.
	# This prevents the check for tab_next and tab_prev inputs.
	# We override the behavior for those 2 inputs in this mod for other menus.
	player_hud.set_process(false)
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	player_hud.set_process(true)

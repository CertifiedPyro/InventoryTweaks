extends Node

const playerhud_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/PlayerHudModded/playerhud_modded.tscn")
const inventory_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/InventoryModded/inventory_modded.tscn")
const journal_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/JournalModded/journal_modded.tscn")
const cosmetic_menu_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/CosmeticMenuModded/cosmetic_menu_modded.tscn")
const shop_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/ShopModded/shop_modded.tscn")


func _ready() -> void:
	get_tree().connect("node_added", self, "_init_mod")
	_register_keybinds()


func _init_mod(node: Node) -> void:
	if node.name == "playerhud":
		var player_hud := node.get_node("main/menu")
		var playerhud_modded := playerhud_modded_scene.instance() as Control
		player_hud.add_child(playerhud_modded)
	elif node.name == "inventory":
		var inventory_modded := inventory_modded_scene.instance() as Control
		node.add_child(inventory_modded)
	elif node.name == "journal":
		var journal_modded := journal_modded_scene.instance() as Control
		node.add_child(journal_modded)
	elif node.name == "outfit":
		var cosmetic_menu_modded := cosmetic_menu_modded_scene.instance() as Control
		node.add_child(cosmetic_menu_modded)
	elif node.name == "shop":
		var shop_modded := shop_modded_scene.instance() as Control
		node.add_child(shop_modded)


func _register_keybinds() -> void:
	# Replace tab_prev and tab_next actions with physical keys
	InputMap.action_erase_events("tab_prev")
	var new_tab_prev_event := InputEventKey.new()
	new_tab_prev_event.physical_scancode = KEY_Q
	InputMap.action_add_event("tab_prev", new_tab_prev_event)
	
	InputMap.action_erase_events("tab_next")
	var new_tab_next_event := InputEventKey.new()
	new_tab_next_event.physical_scancode = KEY_E
	InputMap.action_add_event("tab_next", new_tab_next_event)
	
	# Add page_prev and page_next actions with physical keys
	var new_page_prev_event := InputEventKey.new()
	new_page_prev_event.physical_scancode = KEY_Z
	InputMap.add_action("page_prev")
	InputMap.action_add_event("page_prev", new_page_prev_event)
	
	var new_page_next_event := InputEventKey.new()
	new_page_next_event.physical_scancode = KEY_C
	InputMap.add_action("page_next")
	InputMap.action_add_event("page_next", new_page_next_event)

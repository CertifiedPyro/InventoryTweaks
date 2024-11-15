extends Node

const playerhud_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/playerhud_modded.tscn")
const inventory_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/inventory_modded.tscn")
const journal_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/journal_modded.tscn")
const cosmetic_menu_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/cosmetic_menu_modded.tscn")
const shop_modded_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/shop_modded.tscn")


func _ready() -> void:
	get_tree().connect("node_added", self, "_init_mod")

	
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
	

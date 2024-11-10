extends Node

const sorter_scene := preload("res://mods/CertifiedPyro.InventoryTweaks/sorter.tscn")


func _ready() -> void:
	get_tree().connect("node_added", self, "_init_mod")

	
func _init_mod(node: Node) -> void:
	if node.name != "inventory":
		return
	
	var sorter := sorter_scene.instance() as Control
	
	node.add_child(sorter)

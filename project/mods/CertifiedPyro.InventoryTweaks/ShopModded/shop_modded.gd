extends Control
# Implements modded shop behavior:
# - Sort bait


const Shop := preload("res://Scenes/HUD/Shop/shop.gd")

const BAIT_ORDER = [
	"",
	"worms",
	"cricket",
	"leech",
	"minnow",
	"squid",
	"nautilus"
]

onready var shop := get_parent() as Shop


func _ready() -> void:
	_sort_bait()
	pass


func _on_visibility_changed() -> void:
	if not self.is_visible_in_tree():
		return
	
	_sort_bait()


func _sort_bait() -> void:
	if not PlayerData.bait_unlocked is Array:
		return
	
	if shop == null:
		return
	
	var unlocked_bait := (PlayerData.bait_unlocked as Array).duplicate(true)
	var new_bait_unlocked := []
	for bait in BAIT_ORDER:
		if unlocked_bait.has(bait):
			new_bait_unlocked.append(bait)
	PlayerData.bait_unlocked = new_bait_unlocked
	
	shop._force_refresh()

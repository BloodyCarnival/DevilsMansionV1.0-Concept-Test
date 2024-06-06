extends Node

var inventory = []
var player_node : Node = null
var player_health_component = null
@onready var inventory_slot_scene = preload("res://Scenes/UI/slot.tscn")

signal inventory_updated

func _ready():
	inventory.resize(10)
	Engine.max_fps = 60
func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i].name == item.name and inventory[i].effect == item.effect:
			inventory[i].quantity += item.quantity
			inventory_updated.emit()
			print("items added ", inventory[i].name, inventory[i].quantity)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("items added ", inventory[i].name, inventory[i].quantity)
			return true
	return false
func remove_item(item):
	for i in inventory.size():
		if inventory[i] != null:
			inventory[i].quantity -= 1
			if inventory[i].quantity == 0:
				if inventory[i].name == "Botiquín Médico":
					inventory[i] = null
					print(inventory[i])
					inventory_updated.emit()
					print(inventory)
func set_player_reference(player):
	player_node = player

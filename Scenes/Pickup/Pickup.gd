extends Node3D

@export var item : Item

var scene_path : String = "res://Elements/Pickup/pick_ups.tscn"
var player_in_range : bool = false

func _ready():
	Engine.max_fps = 60
	var instance = item.scene.instantiate()
	add_child(instance)

func _process(_delta):
	if player_in_range == true and Input.is_action_just_pressed("interact"):
		pickup_item(item)

func pickup_item(item):
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false

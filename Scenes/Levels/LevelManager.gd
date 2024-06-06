extends Node


const ENTRANCE_LEVEL = preload("res://Scenes/Levels/Entrance.tscn")
const ROOM_A = preload("res://Scenes/Levels/room_a.tscn")
const ROOM_B = preload("res://Scenes/Levels/room_b.tscn")
const ROOM_C = preload("res://Scenes/Levels/room_c.tscn")
const BOSS_ROOM = preload("res://Scenes/Levels/boss_room.tscn")
const GAME_OVER_SCENE = "res://Scenes/Levels/Gameover_Scene.tscn"
const VICTORY_SCENE = "res://Scenes/Levels/victory_scene.tscn"
var lock_viewport_node : Node = null
var player_spawn
var can_interact_with_lock : bool = false
func changeScene(next_scene, previous_scene):
	var scene_load : PackedScene = load(next_scene)
	var scene_instance = scene_load.instantiate()
	get_tree().get_first_node_in_group("Levels").free()
	get_tree().get_first_node_in_group("LevelManager").add_child(scene_instance)
	
	previous_scene = previous_scene
	move_player(previous_scene, scene_instance)

func move_player(previous_scene, scene_instance):
	var player = Global.player_node
	if previous_scene == "res://Scenes/Levels/room_a.tscn":
		player.start_scene_position(scene_instance.get_child(0).global_position)
	elif previous_scene == "res://Scenes/Levels/room_b.tscn":
		player.start_scene_position(scene_instance.get_child(1).global_position)
	elif previous_scene == "res://Scenes/Levels/room_c.tscn":
		player.start_scene_position(scene_instance.get_child(2).global_position)
	elif previous_scene == "res://Scenes/Levels/Entrance.tscn":
		player.start_scene_position(scene_instance.get_child(0).global_position)
func set_viewport_node(node):
	lock_viewport_node = node

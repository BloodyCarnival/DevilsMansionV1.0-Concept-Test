extends Node3D
var entered : bool = false
@export_file() var next_scene
@export_file() var previous_scene
@export var key_needed : String
func _ready():
	$NeededKey.visible = false
func _process(delta):
	if entered and Input.is_action_just_pressed("interact"):
		if key_needed == "none":
			LevelManager.changeScene(next_scene, previous_scene)
		else:	
			if key_needed != "none":
				$NeededKey.visible = true
			for item in Global.inventory:
				if item:
					if item.name == key_needed:
						LevelManager.changeScene(next_scene, previous_scene)
func _on_player_entered(player):
	if player.is_in_group("Player"):
		entered = true

func _on_player_exited(player):
	if player.is_in_group("Player"):
		entered = false
		$NeededKey.visible = false

extends State
class_name EnemyDeathState

func on_enter():
	character.animations.play("Tpose|Diying")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_player_on_death_animation_finished():
	$"../..".queue_free()

extends Area3D
var entered : bool = false

func _process(delta):
	if entered and Input.is_action_just_pressed("interact"):
		LevelManager.lock_viewport_node.lock_scene.get_node("Lock").can_interact = true
		LevelManager.lock_viewport_node.visible = true
		LevelManager.can_interact_with_lock = true
func _on_player_has_entered(body):
	if body.is_in_group("Player"):
		entered = true

func _on_body_exited(body):
	if body.is_in_group("Player"):
		entered = false
		LevelManager.can_interact_with_lock = false

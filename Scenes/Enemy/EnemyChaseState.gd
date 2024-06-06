extends State
class_name EnemyChaseState
@export var attack_state : State
@export var death_state : State
var player_ref
# Called when the node enters the scene tree for the first time.
func on_enter():
	pass


func state_process(_delta):
	if health_state.health <= 0:
		next_state = death_state
	
	character.animations.play("Tpose|Walk")
	var player_ref = Global.player_node
	character.navigation_agent_3d.set_target_position(player_ref.global_position)
	var next_nav_point = character.navigation_agent_3d.get_next_path_position()
	character.velocity = (next_nav_point - character.global_transform.origin).normalized() * character.SPEED
	character.look_at(player_ref.global_position)
	character.rotate_object_local(Vector3.UP, PI)
	character.move_and_slide()
	
func _on_player_in_attack_range(body):
	if body.is_in_group("Player"):
		next_state = attack_state

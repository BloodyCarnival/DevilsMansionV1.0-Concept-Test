extends State
class_name EnemyState

@export var death_state : State
@export var chase_state : State
func state_process(_delta):
	if health_state.health <= 0:
		next_state = death_state
	character.animations.play("Tpose|Idle")

func player_in_range(body):
	next_state = chase_state

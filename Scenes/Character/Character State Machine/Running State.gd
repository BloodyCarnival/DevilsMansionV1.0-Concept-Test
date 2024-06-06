extends State
class_name RunningState

@export var idle_state = State
@export var walk_state = State
@export var aim_state = State
@export var death_state : State
func on_enter():
	character.MOVE_SPEED = 4

func state_input(event: InputEvent):
	if event.is_action_released("running"):
		next_state = walk_state
	if event.is_action_pressed("aim"):
		next_state = aim_state

func state_process(_delta):
	character.animation_player.play("Prota|Running")
	if health_state.health <= 0:
		next_state = death_state

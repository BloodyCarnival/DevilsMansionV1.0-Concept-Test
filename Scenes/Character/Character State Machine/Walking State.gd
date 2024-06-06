extends State
class_name WalkingState

@export var run_state : State
@export var idle_state : State
@export var aim_state : State
@export var death_state : State
func on_enter():
	character.MOVE_SPEED = 1.5

func state_input(event: InputEvent):
	if event.is_action_pressed("running"):
		next_state = run_state
	if event.is_action_pressed("aim"):
		next_state = aim_state

func state_process(_delta):
	character.animation_player.play("Prota|Walking")
	if character.velocity == Vector3.ZERO:
		next_state = idle_state
	if health_state.health <= 0:
		next_state = death_state

extends State
class_name AimState

@export var idle_state : State
@export var death_state : State
@onready var aim_raycast = $"../../RayCast3D"
@onready var thepowerofchrist = $"../../ThePowerOfChrist"


var enemy_type : String
var attack_damage := 10

func on_enter():
	if character.inventory_interface.equiped_item != null:
		enemy_type = str(character.inventory_interface.equiped_item.item_effect)
	character.animation_player.play("Prota|Pointing")
func state_input(event: InputEvent):
	if event.is_action_released("aim"):
		next_state = idle_state
	if event.is_action_pressed("interact"):
		pray(enemy_type)

func state_process(_delta):
	if health_state.health <= 0:
		next_state = death_state

func pray(enemy_type):
	if aim_raycast.is_colliding():
		if aim_raycast.get_collider().is_in_group(enemy_type):
			thepowerofchrist.play()
			var attack = Attack.new()
			attack.attack_damage = attack_damage
			aim_raycast.get_collider().get_node("Components").get_node("HealthComponent").damage(attack)

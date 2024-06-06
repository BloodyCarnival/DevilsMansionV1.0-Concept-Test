extends CollisionShape3D
class_name CollisionComponent
@export var healthcomponent : HealthState

func damage(attack: Attack):
	if healthcomponent:
		healthcomponent.damage(attack)

class_name Cyclops
extends Enemy

@export
var speed: float = 220
@onready
var health_component : HealthComponent = get_node("HealthComponent")
	
func take_damage(damage_amount : int) -> void:
	health_component.damage(damage_amount)
	print_debug(health_component.current_health)

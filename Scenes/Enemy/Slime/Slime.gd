class_name Slime
extends Enemy


@export var speed: float = 220
@export var navigation_agent: NavigationAgent2D

@onready var health_component : HealthComponent = get_node("HealthComponent")
@onready var player: Player = get_tree().get_first_node_in_group("Player")

var movement_delta: float


func take_damage(damage_amount : int) -> void:
	health_component.damage(damage_amount)
	print_debug(health_component.current_health)
	
func take_charge_damage(damage_amount : int) -> void:
	health_component.damage(damage_amount)
	print_debug(health_component.current_health)

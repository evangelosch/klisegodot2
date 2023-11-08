class_name SlimeState
extends Node


@export
var move_speed: float = 400
@onready
var player: Player = get_tree().get_first_node_in_group("Player")
## Hold a reference to the parent so that it can be controlled by the state
var parent: Slime

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_frame(delta: float) -> SlimeState:
	return null

func process_physics(delta: float) -> SlimeState:
	return null

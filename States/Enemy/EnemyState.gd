class_name EnemyState
extends Node


@export
var move_speed: float = 400
@onready
var player: Player = get_tree().get_first_node_in_group("Player")
## Hold a reference to the parent so that it can be controlled by the state
var parent: Node

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_frame(_delta: float) -> EnemyState:
	return null

func process_physics(_delta: float) -> EnemyState:
	return null

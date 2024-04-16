class_name State
extends Node

@export var move_speed: float = 300


## Hold a reference to the parent so that it can be controlled by the state
var parent: Player

func enter() -> void:
	pass

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

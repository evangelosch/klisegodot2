class_name State
extends Node

var states
var current_state


func _init():
	states = {
		"idle_right": IdleState,
		"attack_right": AttackState,
		"run_right": RunState,
		"parry_right": ParryState
	}


func change_state(new_state_name):
	if get_child_count() != 0:
		get_child(0).queue_free()
	current_state = states.get(new_state_name).new()
	current_state.name = new_state_name
	add_child(current_state)
	print(current_state)

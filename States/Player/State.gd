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
	# Store the last child (if it exists)
	var last_child = null
	if get_child_count() > 0:
		last_child = get_child(get_child_count() - 1)

	# Loop through children and remove all but the last one
	for child in get_children():
		if child != last_child:
			child.queue_free()

	current_state = states.get(new_state_name).new()
	current_state.name = new_state_name
	add_child(current_state)

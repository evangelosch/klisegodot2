extends State


@export
var run_state: State
@export
var idle_state: State
@export
var attack_state: State
@export
var dash_state: State
var input_direction: Vector2
var potential_target: CharacterBody2D = null

func _ready():
	pass

func enter() -> void:
	print(" parry state entered")
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.get_is_mouse_over():
			parent.global_position = enemy.global_position
			break  # Stop after teleporting to the first enemy under the mouse

func process_physics(delta: float) -> State:
	if input_direction == Vector2.ZERO:
		return idle_state
	elif input_direction != Vector2.ZERO:
		return run_state
	elif Input.is_action_just_pressed("attack_right"):
		return attack_state
	elif Input.is_action_just_pressed("dash"):
		return dash_state
	return null

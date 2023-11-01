extends State

@export
var run_state: State
@export
var attack_state: State
@export
var dash_state: State
var input_direction: Vector2


func enter() -> void:
	parent.animation_machine.travel("idle_right")
	input_direction = parent.get_input_direction()

func process_input(event: InputEvent) -> State:
	input_direction = Input.get_vector("move_down", "move_up", "move_left", "move_right")
	if input_direction != Vector2.ZERO:
		return run_state
	if Input.is_action_just_pressed("attack_right"):
		return attack_state
	if Input.is_action_just_pressed("dash"):
		return dash_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO
	parent.move_and_slide()
	return null

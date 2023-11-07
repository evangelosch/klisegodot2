extends State

@export
var run_state: State
@export
var attack_state: State
@export
var dash_state: State
@export
var parry_state: State

var input_direction: Vector2


func enter() -> void:
	parent.animation_machine.travel("idle_right")

func process_input(event: InputEvent) -> State:
	input_direction = parent.get_input_direction()
	if input_direction != Vector2.ZERO:
		return run_state
	if Input.is_action_just_pressed("attack_right"):
		return attack_state
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("parry_right"):
		return parry_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = Vector2.ZERO
	parent.move_and_slide()
	return null

extends State

@export
var idle_state: State
@export
var attack_state: State
@export
var dash_state: State
@export
var parry_state: State

var input_direction: Vector2


func enter() -> void:
	parent.animation_machine.travel("run_right")
	input_direction = parent.get_input_direction()

func process_input(event: InputEvent) -> State:
	input_direction = parent.get_input_direction()
	if input_direction == Vector2.ZERO:
		return idle_state
	if Input.is_action_just_pressed("attack_right"):
		return attack_state
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("parry_right"):
		return parry_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = input_direction * move_speed
	parent.move_and_slide()
	return null

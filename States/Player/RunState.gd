extends State


@export
var idle_state: State
@export
var dash_state: State
@export
var parry_state: State
@export
var charge_attack_state: State
@export
var shoot_state: State

var input_direction: Vector2
var attack_pressed_time: float = 0.0
var is_attack_pressed: bool = false

func enter() -> void:
	parent.animation_machine.travel("run")
	input_direction = parent.get_input_direction()

func process_input(_event: InputEvent) -> State:
	input_direction = parent.get_input_direction()
	
	if input_direction == Vector2.ZERO:
		return idle_state
	if Input.is_action_pressed("charge_attack"):
		return charge_attack_state
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("parry"):
		return parry_state
	if Input.is_action_just_pressed("shoot"):
		return shoot_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = input_direction * move_speed
	parent.move_and_slide()
	if is_attack_pressed:
		attack_pressed_time += delta
	return null

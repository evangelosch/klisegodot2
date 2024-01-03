extends State


@export
var idle_state: State
@export
var attack_state: State
@export
var dash_state: State
@export
var parry_state: State
@export
var charge_attack: State
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
	if Input.is_action_just_pressed("attack_1"):
		print_debug("attack")
		is_attack_pressed = true
		attack_pressed_time = 0.0
	elif Input.is_action_just_released("attack_1"):
		is_attack_pressed = false
		return check_attack()
	if Input.is_action_just_pressed("dash"):
		return dash_state
	if Input.is_action_just_pressed("parry"):
		return parry_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity = input_direction * move_speed
	parent.move_and_slide()
	if is_attack_pressed:
		attack_pressed_time += delta
	return null

func check_attack() -> State:
	# Minimum time to hold for the attack
	var required_hold_time = 0.2
	if attack_pressed_time >= required_hold_time:
		return charge_attack
	else:
		return attack_state

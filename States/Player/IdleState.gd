extends State

@export var run_state: State
@export var idle_state: State
@export var dash_state: State
@export var parry_state: State
@export var charge_attack_state: State
@export var shoot_state: State

var charge_attack_pressed_time: float = 0.0
var is_charge_attack_pressed: bool = false

func enter() -> void:
	parent.animation_machine.travel("idle")


func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed("dash"):
		return dash_state
		
	if Input.is_action_just_pressed("parry"):
		return parry_state
		
	if Input.is_action_just_pressed("shoot"):
		return shoot_state
		
	return null


func process_physics(delta: float) -> State:
	
	if parent.get_input_direction() != Vector2.ZERO:
		return run_state
	
	if Input.is_action_pressed("charge_attack") and not is_charge_attack_pressed:
			is_charge_attack_pressed = true
			charge_attack_pressed_time = 0.0
	
	if is_charge_attack_pressed:
		charge_attack_pressed_time += delta
		if charge_attack_pressed_time >= 0.2:
			is_charge_attack_pressed = false  # Reset flag to prevent repeated checks
			return charge_attack_state
	
	# Check if the charge_attack button was released before reaching the threshold
	if not Input.is_action_pressed("charge_attack") and is_charge_attack_pressed:
		is_charge_attack_pressed = false  # Reset flag for the next press
		charge_attack_pressed_time = 0.0  # Reset the timer for the next press
		
	parent.velocity = Vector2.ZERO
	parent.move_and_slide()
	return null

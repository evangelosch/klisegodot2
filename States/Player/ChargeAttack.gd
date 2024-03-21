extends State

@export
var run_state: State
@export
var idle_state: State
@export
var next_state: State
# Speed of the charge
var charge_speed = 400
# Time the button has been held
var hold_time = 0.0
# Minimum time to hold for the attack
var required_hold_time = 0.5
# Flag to check if attack is ready
var is_attack_ready = false
var charge_level = 0
var charging = false
var input_direction: Vector2

func enter() -> void:
	$"../../ProgressBar".value = charge_level

func exit() -> void:
	charge_level = 0
	$"../../ProgressBar".value = 0
	print_debug("exit")
func process_input(_event: InputEvent) -> State:
	input_direction = parent.get_input_direction()
	return null

func process_frame(_delta: float) -> State:
	if not Input.is_action_just_released("charge_attack"):
		charge_level += 1 * _delta
		$"../../ProgressBar".value = charge_level
	else:	
		charge_attack()
		return idle_state
	return null

func process_physics(_delta: float) -> State:
	parent.velocity = input_direction * 200
	parent.move_and_slide()
	return null

func charge_attack():
	var player_mouse_position = parent.get_global_mouse_position()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", player_mouse_position , 0.1)
	await tween.finished

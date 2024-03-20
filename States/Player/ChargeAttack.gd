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
# Function called every frame
func enter() -> void:
	pass
# Function to perform the attack
func process_frame(_delta: float) -> State:
	if not Input.is_action_just_released("charge_attack"):
		print_debug("Entered")
		charge_level += 1 * _delta
		$"../../ProgressBar".value = charge_level
	else:	
		charge_attack()
		return idle_state
	return self
#func attack() -> State:
	#charge_attack()
	#return idle_state

func charge_attack():
	var player_mouse_position = parent.get_global_mouse_position()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", player_mouse_position , 0.1)
	await tween.finished


#func check_attack() -> State:
	## Minimum time to hold for the attack
	#var required_hold_time = 0.2
	#if attack_pressed_time >= required_hold_time:
		#return charge_attack
	#else:
		#return attack_state

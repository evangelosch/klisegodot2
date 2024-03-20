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

# Function called every frame
func enter() -> void:
	parent.velocity = Vector2.ZERO
	parent.move_and_slide()
# Function to perform the attack
func process_frame(_delta: float) -> State:
	if Input.is_action_just_released("attack_1"):
		return attack()
	return null
	
func attack() -> State:
		
	#particles.emitting = true
	#animated_sprite = parent.get_node("PlayerBody").get_node("AnimatedSprite2D")
	charge_attack()

	return idle_state

func charge_attack():
	var player_mouse_position = parent.get_global_mouse_position()
	var tween = get_tree().create_tween()
	print_debug(parent)
	tween.tween_property(parent, "position", player_mouse_position , 0.1)
	await tween.finished


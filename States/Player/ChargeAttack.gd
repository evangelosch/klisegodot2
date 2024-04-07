extends State

# Exported states
@export var run_state: State
@export var idle_state: State
@export var next_state: State

# Charge mechanics
var charge_speed = 400
var hold_time = 0.0
var required_hold_time = 0.5
var is_attack_ready = false
var charging = false
var charge_time = 0.0
var charge_threshold = 2.0  # Max charge time
var perfect_start_time = 1.2  # Start of perfect charge time
var perfect_end_time = 1.8  # End of perfect charge time
var input_direction: Vector2

# Node references
@onready var aura_particles = $"../../CPUParticles2D"
@onready var timer = $Timer

func enter() -> void:
	aura_particles.modulate = Color(1, 1, 1, 1)
	aura_particles.scale_amount_min = 1
	aura_particles.scale_amount_max = 1
	aura_particles.emitting = true
	charge_time = 0.0
	charging = true

func exit() -> void:
	timer.stop()
	aura_particles.emitting = false
	charging = false
	aura_particles.modulate = Color(0, 0, 0, 0)
	#aura_particles.scale_amount_min = 1
	#aura_particles.scale_amount_max = 1

func process_input(_event: InputEvent) -> State:
	input_direction = parent.get_input_direction()
	return null

func process_frame(_delta: float) -> State:
	if Input.is_action_pressed("charge_attack") and charging:
		charge_time += _delta
		update_aura_intensity(charge_time / charge_threshold)
		
		# Trigger indication for perfect timing
		if charge_time >= perfect_start_time and charge_time <= perfect_end_time:
			show_perfect_timing_indicator()  # Call a method to show the "perfect" indication
		
	elif Input.is_action_just_released("charge_attack") and charging:
		evaluate_charge()
		charge_attack()
		return idle_state
	
	return null


func process_physics(_delta: float) -> State:
	parent.velocity = input_direction * 200
	parent.move_and_slide()
	return null

func charge_attack():
	# Logic for executing the charged attack
	var player_mouse_position = parent.get_global_mouse_position()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", player_mouse_position, 0.1)
	await tween.finished

func update_aura_intensity(ratio: float):
	aura_particles.visible = true
	aura_particles.emitting = true
	# Adjust the aura's appearance based on the charge ratio
	aura_particles.scale = Vector2(1, 1) * (2.0 + ratio)

func evaluate_charge():
	if charge_time < perfect_start_time:
		print_debug("Good")
	elif charge_time >= perfect_start_time and charge_time <= perfect_end_time:
		print_debug("Perfect")
	else:  # charge_time > perfect_end_time
		print_debug("Miss")
	# Reset charge time and stop emitting particles after evaluation
	charge_time = 0.0
	aura_particles.emitting = false

func show_perfect_timing_indicator():
	# Example: Change aura color to indicate perfect timing
	aura_particles.scale_amount_min = 4
	aura_particles.scale_amount_max = 4
	aura_particles.modulate = Color(1, 0, 0, 1)  # Change to red for "perfect" window
	

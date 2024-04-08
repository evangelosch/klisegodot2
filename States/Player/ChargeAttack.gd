extends State

# Exported states
@export var run_state: State
@export var idle_state: State
@export var next_state: State

# Charge mechanics
var charging = false
var charge_time = 0.0
var charge_threshold = 2.0  # Max charge time
var perfect_start_time = 1.2  # Start of perfect charge time
var perfect_end_time = 1.8  # End of perfect charge time
var input_direction: Vector2

# Node references
@onready var aura_particles = $"../../CPUParticles2D"

func enter() -> void:
	aura_particles.modulate = Color(1, 1, 1, 1)
	aura_particles.scale_amount_min = 1
	aura_particles.scale_amount_max = 1
	aura_particles.emitting = true
	charge_time = 0.0
	charging = true


func exit() -> void:
	aura_particles.emitting = false
	charging = false


func process_physics(_delta: float) -> State:
	if Input.is_action_pressed("charge_attack") and charging:
		charge_time += _delta
		update_aura_intensity(charge_time / charge_threshold)
		
		# Trigger indication for perfect timing
		if charge_time >= perfect_start_time and charge_time <= perfect_end_time:
			show_perfect_timing_indicator()  # Call a method to show the "perfect" indication
			
		if charge_time >= charge_threshold:
			aura_particles.emitting = false
			return idle_state
			
	elif Input.is_action_just_released("charge_attack") and charging:
		evaluate_charge()
		return idle_state
	
	input_direction = parent.get_input_direction()
	parent.velocity = input_direction * (move_speed / 2)
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
		charge_attack()
	elif charge_time >= perfect_start_time and charge_time <= perfect_end_time:
		print_debug("Perfect")
		charge_attack()
	# Reset charge time and stop emitting particles after evaluation
	charge_time = 0.0
	aura_particles.emitting = false

func show_perfect_timing_indicator():
	# Example: Change aura color to indicate perfect timing
	aura_particles.scale_amount_min = 4
	aura_particles.scale_amount_max = 4
	aura_particles.modulate = Color(1, 0, 0, 1)  # Change to red for "perfect" window
	

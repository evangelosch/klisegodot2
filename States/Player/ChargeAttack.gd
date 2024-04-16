extends State

# Exported states
@export var run_state: State
@export var idle_state: State
@export var next_state: State

# Charge mechanics
var charging = false
var charge_time = 0.0
var perfect_start_time = 0.7 # Start of perfect charge time
var perfect_end_time = 1.2  # End of perfect charge time
var input_direction: Vector2

# Node references
@onready var aura_particles = $"../../CPUParticles2D"
@onready var charge_hit_box = $"../../ChargeHitBox/CollisionShape2D"


func enter() -> void:
	charge_hit_box.disabled = true
	aura_particles.modulate = Color(1, 1, 1, 1)
	aura_particles.scale_amount_min = 1
	aura_particles.scale_amount_max = 1
	aura_particles.emitting = true
	charge_time = 0.0
	charging = true


func exit() -> void:
	charge_hit_box.disabled = true
	aura_particles.emitting = false
	charging = false


func process_physics(_delta: float) -> State:
	handle_charge_attack_input(_delta)
	
	parent.velocity = parent.get_input_direction() * (move_speed / 2)
	parent.move_and_slide()
	return null

func handle_charge_attack_input(_delta):
	
	if Input.is_action_pressed("charge_attack") and charging:
		charge_time += _delta
		update_aura_intensity(charge_time / perfect_end_time)
		
		# Trigger indication for perfect timing
		if charge_time >= perfect_start_time and charge_time <= perfect_end_time:
			show_perfect_timing_indicator()  # Call a method to show the "perfect" indication
			
		if charge_time > perfect_end_time:
			aura_particles.emitting = false
			return parent.state_machine.change_state(idle_state)
			
	elif Input.is_action_just_released("charge_attack") and charging:
		evaluate_charge()

func charge_attack():
	charge_hit_box.disabled = false
	aura_particles.emitting = false
	# Logic for executing the charged attack
	var direction = (parent.get_global_mouse_position() - parent.global_position).normalized()
	var target_position = parent.global_position + direction * 200

	
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", target_position, 0.1)
	tween.connect("finished", _on_charge_attack_finished)


func _on_charge_attack_finished():
	parent.state_machine.change_state(idle_state)

func update_aura_intensity(ratio: float):
	aura_particles.visible = true
	aura_particles.emitting = true
	# Adjust the aura's appearance based on the charge ratio
	aura_particles.scale = Vector2(1, 1) * (2.0 + ratio)


func evaluate_charge():
	if charge_time < perfect_start_time:
		print_debug("Good")
		return charge_attack()
	elif charge_time >= perfect_start_time and charge_time <= perfect_end_time:
		print_debug("Perfect")
		return charge_attack()
	# Reset charge time and stop emitting particles after evaluation
	charge_time = 0.0
	aura_particles.emitting = false
	return parent.state_machine.change_state(idle_state)

func show_perfect_timing_indicator():
	# Example: Change aura color to indicate perfect timing
	aura_particles.scale_amount_min = 4
	aura_particles.scale_amount_max = 4
	aura_particles.modulate = Color(1, 0, 0, 1)  # Change to red for "perfect" window

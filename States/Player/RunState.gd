extends State

@export
var idle_state: State

@export
var attack_state: State


func enter() -> void:
	parent.animation_machine.travel("run_right")

func process_input(event: InputEvent) -> State:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction == Vector2.ZERO:
		return idle_state
	if Input.is_action_just_pressed("attack_right"):
		print("Attack")
		return attack_state
	return null


func process_physics(delta: float) -> State:
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction == Vector2.ZERO:
		return idle_state
	
	parent.velocity = input_direction * move_speed
	parent.move_and_slide()
	return null

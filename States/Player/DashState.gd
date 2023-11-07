extends State

@export
var run_state: State
@export
var idle_state: State
@export
var attack_state: State
@export var dash_speed: float = 10000  # The speed of the dash
@export var dash_distance: float = 20000  # The fixed distance of the dash

var dash_direction: Vector2
var distance_dashed: float = 0.0  # The distance already dashed
var input_direction: Vector2


func enter():
	input_direction = parent.get_input_direction()
	dash_direction = input_direction
	parent.velocity = dash_direction * dash_distance
	parent.move_and_slide()

func process_physics(delta: float) -> State:
	if input_direction == Vector2.ZERO:
		return idle_state
	elif input_direction != Vector2.ZERO:
		return run_state
	elif Input.is_action_just_pressed("attack_right"):
		return attack_state
	return null

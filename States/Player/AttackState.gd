extends State

@export
var run_state: State
@export
var idle_state: State
@onready
var animation_tree = get_parent().get_parent().get_node("AnimationTree")

var animation_ended = false
var input_direction: Vector2


func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)

func enter() -> void:
	animation_ended = false
	parent.animation_machine.travel("attack_right")

# Callback for the animation_ended signal
func _on_animation_tree_animation_finished(animation_name: String):
	if animation_name == "attack_right": # Check if it's the correct animation
		animation_ended = true

func process_physics(delta: float) -> State:
	input_direction = parent.get_input_direction()
	if input_direction == Vector2.ZERO and animation_ended:
		return idle_state
	elif input_direction != Vector2.ZERO and not animation_ended:
		parent.velocity = input_direction * move_speed
		parent.move_and_slide()
	elif input_direction != Vector2.ZERO and animation_ended:
		return run_state
	return null

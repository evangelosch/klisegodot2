extends State

@export
var run_state: State
@export
var idle_state: State
@export
var next_state: State
@onready
var animation_tree = get_parent().get_parent().get_node("AnimationTree")

var animation_ended = false
var input_direction: Vector2
var is_attacking: bool
var attack_pressed: bool = false


func _ready():
	animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)

func enter() -> void:
	animation_ended = false
	parent.animation_machine.travel("attack_1")

# Callback for the animation_ended signal
func _on_animation_tree_animation_finished(animation_name: String):
	if animation_name == "attack_1":
		animation_ended = true
		is_attacking = false

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("attack_1"):
		if animation_ended:
			return next_state
	return null
	

func process_physics(_delta: float) -> State:
	input_direction = parent.get_input_direction()
	
	if input_direction == Vector2.ZERO and animation_ended:
		return idle_state
	elif input_direction != Vector2.ZERO and not animation_ended:
		parent.velocity = input_direction * move_speed
		parent.move_and_slide()
	elif input_direction != Vector2.ZERO and animation_ended:
		return run_state

	return null


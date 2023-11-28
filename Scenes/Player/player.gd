class_name Player
extends CharacterBody2D


@onready
var state_machine : Node = get_node("State_machine")
@onready
var animation_machine = get_node("AnimationTree").get("parameters/playback")
@onready
var animation_tree : AnimationTree = get_node("AnimationTree")
@onready
var player_sprite : AnimatedSprite2D = get_node("PlayerBody").get_node("AnimatedSprite2D")
signal player_direction(facing_right : bool)

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func get_input_direction():
	flip()
	return Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()

func flip():
	var direction = sign(get_global_mouse_position().x - player_sprite.global_position.x)
	if direction < 0:
		player_sprite.set_flip_h(true)
	else:
		player_sprite.set_flip_h(false)
		
	emit_signal("player_direction", !player_sprite.flip_h)

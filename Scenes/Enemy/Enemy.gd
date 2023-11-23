class_name Enemy
extends CharacterBody2D

@onready
var state_machine = get_node("EnemyState_machine")
@onready
var ray_cast : RayCast2D = get_node("RayCast2D")
var is_mouse_over = false

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	self.input_pickable = true
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_mouse_entered():
	is_mouse_over = true

func _on_mouse_exited():
	is_mouse_over = false

func get_is_mouse_over() -> bool:
	return is_mouse_over

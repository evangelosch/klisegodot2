class_name Enemy
extends CharacterBody2D

@onready
var state_machine = get_node("EnemyState_machine")
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
	print("Mouse is over enemy")

func _on_mouse_exited():
	is_mouse_over = false
	print("Mouse is not over enemy")

func get_is_mouse_over() -> bool:
	return is_mouse_over

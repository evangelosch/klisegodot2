class_name Cyclops
extends Enemy


@export
var speed: float = 220
@onready
var ray_cast : RayCast2D = get_node("RayCast2D")

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	self.input_pickable = true
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)


#func _ready():
#	connect("mouse_entered", _on_mouse_entered)
#	connect("mouse_exited", _on_mouse_exited)
#	self.input_pickable = true
#
#func _on_mouse_entered():
#	is_mouse_over = true
#	print("Mouse is over enemy")
#
#func _on_mouse_exited():
#	is_mouse_over = false
#	print("Mouse is not over enemy")
#
#func get_is_mouse_over() -> bool:
#	return is_mouse_over

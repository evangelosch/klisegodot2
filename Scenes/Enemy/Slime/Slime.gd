class_name Slime
extends Enemy


@export
var speed: float = 220
@onready
var progress_bar : ProgressBar = $ProgressBar

var health: = 2:
	set(value):
		health = value
		progress_bar.value = value

func _input(event):
	if event.is_action_pressed("damage"):
		health -= 1
#func _ready() -> void:
#	# Initialize the state machine, passing a reference of the player to the states,
#	# that way they can move and react accordingly
#	state_machine.init(self)
#
#func _physics_process(delta: float) -> void:
#	state_machine.process_physics(delta)
#
#func _process(delta: float) -> void:
#	state_machine.process_frame(delta)

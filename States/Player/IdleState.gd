class_name IdleState
extends State

var state_machine
var player


func _ready():
	player = get_parent().get_parent()


func _physics_process(delta):
	if player.input_direction == Vector2.ZERO:
		player.state.change_state("idle_right")
		player.state_machine.travel("idle_right")

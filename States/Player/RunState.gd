class_name RunState
extends State

var state_machine
var player


func _ready():
	player = get_parent().get_parent()


func _physics_process(delta):
	if player.input_direction != Vector2.ZERO:
		player.velocity = player.input_direction * player.speed
		player.state_machine.travel("run_right")
		player.move_and_slide()

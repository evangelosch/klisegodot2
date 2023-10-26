class_name AttackState
extends State

var state_machine
var player


func _ready():
	player = get_parent().get_parent()


func _physics_process(delta):
	if Input.is_action_just_pressed("attack_right"):
		player.state.change_state("attack_right")
		player.state_machine.travel("attack_right")

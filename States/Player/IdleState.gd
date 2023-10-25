class_name IdleState
extends State

var player
#@onready var animation_player: AnimationPlayer
@onready var animation_tree: AnimationTree
var state_machine

func _ready():
	player = get_parent().get_parent()
	animation_tree = player.get_node("AnimationTree")
	#animation_tree.animation_finished.connect(on_AttackAnimation_finished)
	state_machine = animation_tree.get("parameters/playback")
#	state_machine.travel("attack_right")


func _physics_process(delta):
	state_machine.travel("idle_right")
	

#
#func on_AttackAnimation_finished(animation_name: String):
#	player.state.change_state("idle_right")

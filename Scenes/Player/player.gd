extends CharacterBody2D

var state_machine
var state
var input_direction: Vector2 = Vector2.ZERO
@export var speed = 300
@onready var animation_tree : AnimationTree = $AnimationTree


func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	state = State.new()
	state.name = "State"
	add_child(state)
	#state.change_state("idle_right")


func _physics_process(_delta):
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#move_and_slide()


func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#	if input_direction == Vector2.ZERO:
#		state.change_state("idle_right")
#		velocity = Vector2.ZERO
#	elif input_direction != Vector2.ZERO:
#		state.change_state("run_right")
#		velocity = input_direction * speed


# kanei 2 states epidi exw 2 functions get input kai attack.
#func attack():
#	if Input.is_action_just_pressed("attack_right"):
#		state.change_state("attack_right")

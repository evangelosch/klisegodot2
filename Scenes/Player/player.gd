extends CharacterBody2D

var state_machine
var input_direction: Vector2 = Vector2.ZERO
@export var speed = 300
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	state_machine = $AnimationTree.get("parameters/playback")

#	state = State.new()
#	state.name = "State"
#	add_child(state)
#	state.change_state("idle_right")
##	animation_tree.active = true
##	animation_player.play("idle_right")


func _process(delta):
	pass
#	if Input.is_action_just_pressed("attack_right"):
#		state.change_state("attack_right")
	#handle animations
	#update_animation_parameters()



func _physics_process(_delta):
	get_input()
	move_and_slide()


func get_input():
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction == Vector2.ZERO:
		state_machine.travel("idle_right")
		velocity = Vector2.ZERO
		print("idle")
	elif input_direction != Vector2.ZERO:
		state_machine.travel("run_right")
		velocity = input_direction * speed
		print("running")
	
	if Input.is_action_just_pressed("attack_right"):
		state_machine.travel("attack_right")
	if Input.is_action_just_pressed("parry_right"):
		state_machine.travel("parry_right")
		print("parry")

#func update_animation_parameters():
#	if velocity == Vector2.ZERO:
#		animation_tree["parameters/conditions/is_idle"] = true
#		animation_tree["parameters/conditions/is_running"] = false
#	else:
#		animation_tree["parameters/conditions/is_idle"] = false
#		animation_tree["parameters/conditions/is_running"] = true
#	if (Input.is_action_just_pressed("parry_right")):
#		animation_tree["parameters/conditions/is_parrying"] = true
#		animation_tree["parameters/conditions/is_idle"] = false

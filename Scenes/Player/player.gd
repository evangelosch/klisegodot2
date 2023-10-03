extends CharacterBody2D

@export var speed = 300
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _ready():
	animation_tree.active = true
	#animation_player.play("parry_right")


func _process(delta):
	pass
	#handle animations
#	update_animation_parameters()



func _physics_process(_delta):
	get_input()
	move_and_slide()


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed


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

extends CharacterBody2D


var MAX_SPEED = 300
const MAX_FORCE = 0.02

@onready var player: Player = get_tree().get_first_node_in_group("Player")

@export_enum("SEEK", "FLEE") var mode: int
func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	velocity = steer(player.global_position)
	move_and_slide()
	var target = player.global_position
	
	
func steer(target):
	var desired_velocity = Vector2(target - position).normalized() \
	* MAX_SPEED

	if mode == 0:
		pass
	elif mode == 1:
		desired_velocity = -desired_velocity
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE)
	return(target_velocity)


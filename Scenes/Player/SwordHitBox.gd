extends Area2D

@export
var player : Player
@export
var sword_collision_shape : SwordCollisionShape
# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("player_direction", _on_player_direction_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_direction_changed(facing_right : bool):
	if facing_right:
		sword_collision_shape.position = sword_collision_shape.right_direction
	else :
		sword_collision_shape.position = sword_collision_shape.left_direction

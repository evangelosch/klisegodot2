class_name SwordHitBox
extends Area2D

@export
var sword : Sword
@export
var sword_collision_shape : SwordCollisionShape
@export
var damage : int = 1

func _init():
	collision_layer = 4
	collision_mask = 0

#func _ready():
#	sword.connect("player_direction", _on_player_direction_changed)
#
#func _on_player_direction_changed(facing_right : bool):
#	if facing_right:
#		sword_collision_shape.position = sword_collision_shape.right_direction
#	else :
#		sword_collision_shape.position = sword_collision_shape.left_direction

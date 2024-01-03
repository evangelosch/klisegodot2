class_name Sword
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#var mouse_pisition = get_global_mouse_position()
	##look_at(get_global_mouse_position())
	#if mouse_pisition.x < 0:
		#self.rotation = -20
	look_at(get_global_mouse_position())
#	var mouse_position = get_global_mouse_position()
#	var player_position = get_parent().position
#
#
#
#	if mouse_position.x < player_position.x:
#
#		$Sprite2D.flip_h
#		$Sprite2D.scale.y = -0.05
#	else:
#		$Sprite2D.scale.y = 0.05
	

#func flip():
#	var direction = look_at(get_parent().position)
#	if direction < 0:
#		player_sprite.set_flip_h(true)
#	else:
#		player_sprite.set_flip_h(false)
#
#	emit_signal("player_direction", !player_sprite.flip_h)

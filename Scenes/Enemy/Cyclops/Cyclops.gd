# Cyclops.gd
extends CharacterBody2D

var is_mouse_over = false

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	self.input_pickable = true

func _on_mouse_entered():
	is_mouse_over = true
	print("Mouse is over enemy")

func _on_mouse_exited():
	is_mouse_over = false
	print("Mouse is not over enemy")

func get_is_mouse_over() -> bool:
	return is_mouse_over

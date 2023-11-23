class_name Slime
extends Enemy


@export
var speed: float = 220
@onready
var progress_bar : ProgressBar = $ProgressBar

var health: = 2:
	set(value):
		health = value
		progress_bar.value = value

func _input(event):
	if event.is_action_pressed("damage"):
		health -= 1

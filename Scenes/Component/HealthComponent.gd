class_name HealthComponent
extends Node

@export
var progress_bar : ProgressBar
signal died
@export
var max_health : float 
var current_health : float


func _ready():
	current_health = max_health
	progress_bar.max_value = current_health
	progress_bar.value = current_health
	print_debug(progress_bar.value)

func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	progress_bar.value = current_health
	if current_health == 0:
		died.emit()
		owner.queue_free()

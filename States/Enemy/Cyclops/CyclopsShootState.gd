extends EnemyState


@export var bullet_node : PackedScene
# Called when the node enters the scene tree for the first time.
@onready
var timer = get_node("Timer")

func enter():
	timer.start()

func exit():
	timer.stop()

func _on_timer_timeout():
	shoot()

func shoot():
	var bullet = bullet_node.instantiate()
	bullet.position = parent.global_position
	bullet.direction = (player.position - parent.global_position).normalized()
	get_tree().current_scene.call_deferred("add_child", bullet)

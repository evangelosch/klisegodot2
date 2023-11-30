extends EnemyState

@export
var follow_state: EnemyState
@export
var dash_state: EnemyState
@export var bullet_node : PackedScene
# Called when the node enters the scene tree for the first time.
@onready
var timer = get_node("Timer")

func enter():
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func exit():
	timer.disconnect("timeout", _on_timer_timeout)
	timer.stop()

func _on_timer_timeout():
	shoot()

func shoot() -> EnemyState:
	var bullet = bullet_node.instantiate()
	bullet.position = parent.global_position
	bullet.direction = (player.position - parent.global_position).normalized()
	get_tree().current_scene.call_deferred("add_child", bullet)
	if parent.ray_cast.is_colliding():
		var collider = parent.ray_cast.get_collider()
		if not collider.is_in_group("Player"):
			return parent.state_machine.change_state(follow_state)
	if not parent.ray_cast.is_colliding():
		return parent.state_machine.change_state(follow_state)
	return null

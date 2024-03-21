extends EnemyState


var direction: Vector2 = Vector2.ZERO
@export
var shoot_state: EnemyState
@export
var idle_state: EnemyState

func enter():
	pass

func process_physics(delta: float) -> EnemyState:
	parent.velocity = (player.position - parent.global_position).normalized() * parent.speed
	parent.move_and_slide()
	direction = (player.position - parent.global_position).normalized()
	parent.ray_cast.target_position = direction * 100
	if parent.ray_cast.is_colliding():
		var collider = parent.ray_cast.get_collider()
		if collider.is_in_group("Player"):
			return shoot_state
		
	return null

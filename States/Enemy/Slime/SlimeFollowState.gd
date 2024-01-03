extends EnemyState


var direction: Vector2 = Vector2.ZERO
@export
var shoot_state: EnemyState
@export
var idle_state: EnemyState
@export
var dash_state: EnemyState

func enter():
	pass
	#print("entered follow state")

func process_physics(_delta: float) -> EnemyState:
	parent.velocity = (player.position - parent.global_position).normalized() * parent.speed
	parent.move_and_slide()
	direction = (player.position - parent.global_position).normalized()
	parent.ray_cast.target_position = direction * 100
	if parent.ray_cast.is_colliding():
		var collider = parent.ray_cast.get_collider()
		if collider.is_in_group("Player"):
			return shoot_state
	if parent.ray_cast.is_colliding():
		var collider = parent.ray_cast.get_collider()
		if not collider.is_in_group("Player"):
			return self
	if not parent.ray_cast.is_colliding():
		if parent.health_component.current_health <= 5:
				return dash_state
	return null

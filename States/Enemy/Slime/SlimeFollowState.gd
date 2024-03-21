extends EnemyState


var direction: Vector2 = Vector2.ZERO
@export
var shoot_state: EnemyState
@export
var idle_state: EnemyState
@export
var dash_state: EnemyState
var randomnum

func enter():
	pass
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()

func process_physics(_delta: float) -> EnemyState:
	parent.velocity = (get_circle_position(randomnum) - parent.global_position).normalized() * parent.speed
	parent.move_and_slide()
	direction = (player.position - parent.global_position).normalized()
	parent.ray_cast.target_position = direction * 30
	#if parent.ray_cast.is_colliding():
		#var collider = parent.ray_cast.get_collider()
		#if collider.is_in_group("Player"):
			#return shoot_state
	#if parent.ray_cast.is_colliding():
		#var collider = parent.ray_cast.get_collider()
		#if not collider.is_in_group("Player"):
			#return self
		#return dash_state
	#if not parent.ray_cast.is_colliding():
		#if parent.health_component.current_health <= 5:
				#return dash_state
	return null

func get_circle_position(random):
	var kill_circle_centre = player.global_position
	var radius = 100
	 #Distance from center to circumference of circle
	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)

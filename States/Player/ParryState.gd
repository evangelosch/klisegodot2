extends State


@export
var run_state: State
@export
var idle_state: State
@export
var attack_state: State
@export
var dash_state: State
var input_direction: Vector2
var dash_direction: Vector2
var is_dashing = false
var dash_distance = 30000
var target_enemy: Enemy
var collision


func enter():
	collision = false

func process_physics(delta: float) -> State:
	start_dash()
	if is_dashing:
		parent.velocity = dash_distance * dash_direction * delta
		parent.move_and_collide(parent.velocity)
		for index in parent.get_slide_collision_count():
			collision = parent.get_slide_collision(index)
			var body = collision.get_collider()
			if body.name == target_enemy.name:
				parent.velocity = collision.get_position()
				is_dashing = false
				#parent.move_and_slide()
				handle_dash_collision_with_enemy()
		#return idle_state
	if parent.get_input_direction() == Vector2.ZERO:
		return idle_state
	else:
		return run_state

func start_dash():
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.get_is_mouse_over():
			target_enemy = enemy
			dash_direction = (target_enemy.global_position - parent.global_position).normalized() 
			is_dashing = true
			break #once enemy under mouse is found break from the loop
		else :
			is_dashing = false

func handle_dash_collision_with_enemy() -> State:
	if is_parry_successful():
		return idle_state
	else:
		# Handle unsuccessful parry
		print("Parry failed")
		return idle_state


func is_parry_successful() -> bool:
	return true

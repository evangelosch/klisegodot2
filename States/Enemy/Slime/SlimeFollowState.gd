extends EnemyState


@export var shoot_state: EnemyState
@export var idle_state: EnemyState
@export var dash_state: EnemyState


func enter() -> void:
	parent.navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))


func exit() -> void:
	parent.navigation_agent.velocity_computed.disconnect(Callable(_on_velocity_computed))
	
	
func _ready() -> void:
	set_physics_process(false)
	call_deferred("enemies_setup")


func process_physics(_delta: float) -> EnemyState:
	
	if parent.navigation_agent.distance_to_target() < 200:
		return dash_state
	make_path_to_player()
	var next_path_position: Vector2 = parent.navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = parent.global_position.direction_to(next_path_position) * parent.speed
	if parent.navigation_agent.avoidance_enabled:
		parent.navigation_agent.set_velocity(new_velocity)
		return self
	else:
		_on_velocity_computed(new_velocity)
		return self


func make_path_to_player():
	parent.navigation_agent.target_position = player.global_position


func enemies_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_physics_process(true)


func _on_velocity_computed(safe_velocity: Vector2):
	parent.velocity = safe_velocity
	parent.move_and_slide()

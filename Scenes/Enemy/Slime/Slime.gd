class_name Slime
extends Enemy


@export
var speed: float = 220
@export
var navigation_agent: NavigationAgent2D
@onready
var health_component : HealthComponent = get_node("HealthComponent")

@onready
var player: Player = get_tree().get_first_node_in_group("Player")
var movement_delta: float

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	set_physics_process(false)
	call_deferred("enemies_setup")
	
func _physics_process(delta):
	#if navigation_agent.is_navigation_finished():
		#return
	make_path_to_player()
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * speed
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func take_damage(damage_amount : int) -> void:
	health_component.damage(damage_amount)
	print_debug(health_component.current_health)
	
	
func make_path_to_player():
	navigation_agent.target_position = player.global_position


func enemies_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	set_physics_process(true)


func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

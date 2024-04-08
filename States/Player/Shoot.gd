extends State

@export var run_state: State
@export var idle_state: State
@export var next_state: State
@export var bullet_node: PackedScene

@onready var animation_tree = get_parent().get_parent().get_node("AnimationTree")
@onready var timer = get_node("Timer")

var animation_ended = false
var input_direction: Vector2
var speed = 400  # Bullet speed
var fire_rate = 0.5  # Time between shots (seconds)
var can_shoot = true


func enter():
	
	if not timer.is_connected("timeout", _on_timer_timeout):
		timer.connect("timeout", _on_timer_timeout)
		
	if can_shoot:
		shoot()
		can_shoot = false
		timer.start()


func process_physics(_delta: float) -> State:
	
	if not parent.get_input_direction() == Vector2.ZERO:
		return run_state
		
	return idle_state


func _on_timer_timeout():
	can_shoot = true


func shoot() -> State:
	var mouse_position = parent.get_global_mouse_position()
	var direction = (mouse_position - parent.position).normalized()
	var bullet = bullet_node.instantiate()
	bullet.position = parent.global_position
	bullet.direction = direction
	get_tree().current_scene.call_deferred("add_child", bullet)
	
	return null

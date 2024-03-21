extends State

@export
var run_state: State
@export
var idle_state: State
@export
var next_state: State
@onready
var animation_tree = get_parent().get_parent().get_node("AnimationTree")
@export 
var bullet_node: PackedScene
@onready
var timer = get_node("Timer")

var animation_ended = false
var input_direction: Vector2

var speed = 400  # Bullet speed
var fire_rate = 0.5  # Time between shots (seconds)

#
#func _ready():
	#animation_tree.animation_finished.connect(_on_animation_tree_animation_finished)


func enter():
	timer.connect("timeout", _on_timer_timeout)
	#timer.start()

func process_physics(_delta: float) -> State:
	shoot()
	return idle_state

func exit():
	timer.disconnect("timeout", _on_timer_timeout)
	timer.stop()

func _on_timer_timeout():
	shoot()

func shoot() -> State:
	var mouse_position = parent.get_global_mouse_position()
	var direction = (mouse_position - parent.position).normalized()
	var bullet = bullet_node.instantiate()
	bullet.position = parent.global_position
	bullet.direction = direction
	get_tree().current_scene.call_deferred("add_child", bullet)
	
	return idle_state

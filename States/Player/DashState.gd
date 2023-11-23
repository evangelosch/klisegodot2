extends State

@export
var run_state: State
@export
var idle_state: State
@export
var attack_state: State
@export 
var dash_speed: float = 10000  # The speed of the dash
@export
var dash_distance: float = 20000  # The fixed distance of the dash
@export
var dash_effect : PackedScene
@onready
var dash_timer = get_node("DashTimer")
@onready
var animated_sprite : AnimatedSprite2D 

var dash_direction: Vector2
var distance_dashed: float = 0.0  # The distance already dashed
var input_direction: Vector2


func enter():
	if not dash_timer.is_connected("timeout", _on_dash_timer_timeout):
		dash_timer.connect("timeout", _on_dash_timer_timeout)
		
	#particles.emitting = true
	animated_sprite = parent.get_node("PlayerBody").get_node("AnimatedSprite2D")
	dash_timer.start()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", parent.position + parent.velocity * 0.8, 0.3)
	await tween.finished
	dash_timer.stop()
	#particles.emitting = false
	
#	input_direction = parent.get_input_direction()
#	dash_direction = input_direction
#	parent.velocity = dash_direction * dash_distance
#	parent.move_and_slide()
#func exit():
#	dash_timer.disconnect("timeout", _on_dash_timer_timeout)

#func exit():
#	dash_timer.disconnect("timeout", _on_dash_timer_timeout)

func _on_dash_timer_timeout():
	add_dash_effect()

func add_dash_effect():
	var effect = dash_effect.instantiate()
	effect.set_property(parent.position, animated_sprite.scale + Vector2(1,1))
	print(animated_sprite.scale)
	get_tree().current_scene.add_child(effect)

func process_physics(delta: float) -> State:
#	if input_direction == Vector2.ZERO:
	return idle_state
#	elif input_direction != Vector2.ZERO:
#		return run_state
#	elif Input.is_action_just_pressed("attack_right"):
#		return attack_state
#	return null

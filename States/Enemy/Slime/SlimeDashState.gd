extends EnemyState

@export var follow_state: EnemyState

@onready var timer = get_node("Timer")
var dash_counter: int = 0

func enter():
	dash_counter = 0
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
	print_debug("yoyo")


func exit():
	timer.disconnect("timeout", _on_timer_timeout)
	timer.stop()
	dash_counter = 0


func _on_timer_timeout():
	dash()
	

func dash():

	print_debug(dash_counter)
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.3)
	tween.connect("finished", _on_dash_completed)

func _on_dash_completed() -> EnemyState:
	dash_counter += 1
	if dash_counter >= 2:
		parent.velocity = Vector2.ZERO
		get_tree().create_timer(3.0).timeout 
		return get_parent().change_state(follow_state)
	return dash()
	

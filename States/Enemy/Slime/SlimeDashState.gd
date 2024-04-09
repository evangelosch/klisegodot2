extends EnemyState

@export var follow_state: EnemyState

@onready var timer = get_node("Timer")

func enter():
	timer.connect("timeout", _on_timer_timeout)
	timer.start()
	print_debug("yoyo")


func exit():
	timer.disconnect("timeout", _on_timer_timeout)
	timer.stop()


func _on_timer_timeout():
	dash()
	

func dash():
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.3)
	#return parent.state_machine.change_state(follow_state)
	tween.connect("finished", _on_dash_completed)

func _on_dash_completed() -> EnemyState:
		return follow_state

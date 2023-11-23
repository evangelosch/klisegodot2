extends EnemyState

@export
var follow_state: EnemyState
@onready
var timer = get_node("Timer")

func enter():
	timer.connect("timeout", _on_timer_timeout)
	timer.start()

func exit():
	timer.disconnect("timeout", _on_timer_timeout)
	timer.stop()

func _on_timer_timeout():
	dash()
	

func dash() -> EnemyState:
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 0.3)
	return parent.state_machine.change_state(follow_state)

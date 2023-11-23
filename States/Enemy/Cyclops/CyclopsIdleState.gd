extends EnemyState

@onready var ray_cast = get_parent().get_parent().get_node("RayCast2D")
@export
var shoot_state: EnemyState
@export
var follow_state: EnemyState
var direction

func enter():
	pass

func process_frame(delta: float) -> EnemyState:
		return follow_state

extends EnemyState


@export var shoot_state: EnemyState
@export var follow_state: EnemyState

@onready var ray_cast = get_parent().get_parent().get_node("RayCast2D")

func enter():
	pass

func process_frame(_delta: float) -> EnemyState:
		return follow_state

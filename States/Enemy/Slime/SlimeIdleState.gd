extends EnemyState


@export var shoot_state: EnemyState
@export var follow_state: EnemyState

func enter():
	pass

func process_frame(_delta: float) -> EnemyState:
		return follow_state

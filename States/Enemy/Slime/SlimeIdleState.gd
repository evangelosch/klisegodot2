extends SlimeState

@onready var ray_cast = get_parent().get_parent().get_node("RayCast2D")
@export
var shoot_state: SlimeState
@export
var follow_state: SlimeState
var direction

func enter():
	pass

func process_frame(delta: float) -> SlimeState:
		return follow_state

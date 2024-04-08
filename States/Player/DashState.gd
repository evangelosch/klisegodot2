extends State


@export var idle_state: State
@export var dash_speed: float = 10000  # The speed of the dash
@export var dash_distance: float = 20000  # The fixed distance of the dash

@onready var dash_timer = get_node("DashTimer")
@onready var animated_sprite : AnimatedSprite2D 

var dash_direction: Vector2
var distance_dashed: float = 0.0  # The distance already dashed
var input_direction: Vector2


func enter():
	animated_sprite = parent.get_node("PlayerBody").get_node("AnimatedSprite2D")
	dash_timer.start()
	var tween = get_tree().create_tween()
	tween.tween_property(parent, "position", parent.position + parent.velocity * 0.65, 0.3)
	await tween.finished
	dash_timer.stop()


func process_physics(_delta: float) -> State:
	return idle_state

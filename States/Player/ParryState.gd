class_name ParryState
extends State

var player
@onready var animation_player: AnimationPlayer


func _ready():
	player = get_parent().get_parent()
	animation_player = player.get_node("AnimationPlayer")


func _physics_process(delta):
	animation_player.play("parry_right")

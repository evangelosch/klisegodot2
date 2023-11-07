class_name Slime
extends CharacterBody2D

@onready
var state_machine = $SlimeState_machine
@export
var speed: float = 220
@onready
var ray_cast : RayCast2D = $RayCast2D
#@onready
#var animation_machine = $AnimationTree.get("parameters/playback")
#@onready
#var animation_tree = $AnimationTree

func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

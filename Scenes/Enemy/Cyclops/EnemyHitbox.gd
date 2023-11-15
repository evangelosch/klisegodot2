extends Area2D

@onready
var hitbox : Area2D = get_node(".")
var parent : Enemy
func _ready():
	parent = get_parent()
	hitbox.connect("area_entered", _on_Area2D_area_entered)
	

func _on_Area2D_area_entered(area):
	if area.get_parent().is_in_group("Player"):
#		parent.velocity = Vector2(-10000, 0)
#		parent.move_and_slide()

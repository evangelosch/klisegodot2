class_name HurtBox
extends Area2D


func _init():
	collision_layer = 0
	collision_mask = 4

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(hitBox : SwordHitBox) -> void:
	if hitBox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitBox.damage)

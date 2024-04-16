extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", _charge_attack_area_entered)

func _charge_attack_area_entered(area):
	 # Check if the entered area is a hurtbox
	if area.name == "HurtBoxComponent":
	# Assuming the HealthComponent is attached to the parent of the hurtbox
		var enemy = area.get_parent()
		print_debug(enemy)
		if enemy and enemy.has_method("take_charge_damage"):
		# Apply damage
			enemy.take_charge_damage(2.0)  # Example damage value
		

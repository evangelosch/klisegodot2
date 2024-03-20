extends Area2D


var direction: Vector2 = Vector2.RIGHT
var speed: float = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", on_bullet_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func on_bullet_area_entered(area):
	 # Check if the entered area is a hurtbox
	if area.name == "HurtBox":
	# Assuming the HealthComponent is attached to the parent of the hurtbox
		var enemy = area.get_parent()
		print_debug(enemy)
		if enemy and enemy.has_method("take_damage"):
		# Apply damage
			enemy.take_damage(1.0)  # Example damage value
		queue_free()  # Optionally, remove the bullet

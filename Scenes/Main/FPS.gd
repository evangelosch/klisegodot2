extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
<<<<<<<< HEAD:Scenes/Main/FPS.gd
func _process(delta):
	var fps = Engine.get_frames_per_second()
	text = "FPS: " + str(fps) 
========
func _process(_delta):
	pass
>>>>>>>> 04ad2db24d884662c08ccfe3feed20ff68c4302d:Scenes/Player/SwordCollisionShape.gd

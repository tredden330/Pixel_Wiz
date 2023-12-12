extends PathFollow2D

var playing = false
var speed = 5.0
var ratio = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		ratio += delta*speed
		if ratio > 1:
			progress_ratio = 1
		else:
			progress_ratio = ratio

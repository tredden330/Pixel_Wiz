extends Node2D

var speed = 1.0
var direction = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction

func set_direction(direction1):
	direction = direction1

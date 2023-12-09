extends Node2D

var speed = 1.0
var direction

var xpos = 0
var ypos = 0

var xlim = 9
var ylim = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _moveProjectile():
	if (direction == null):
		pass
	elif (direction == Vector2(0,-1)):
		ypos -= 1
		rotation_degrees = -90
	elif (direction == Vector2(0,1)):
		ypos += 1
		rotation_degrees = 90
	elif (direction == Vector2(-1,0)):
		xpos -= 1
		rotation_degrees = 180
	elif (direction == Vector2(1,0)):
		xpos += 1
		
	
	position.y = (ypos * 128) + 64
	position.x = (xpos * 128) + 64
	#despawn at max range
	if xpos > xlim or xpos < 0:
		queue_free()
	if ypos > xlim or ypos < 0:
		queue_free()

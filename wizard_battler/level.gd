extends Node2D

var time = 0.0
var up = 4

#vars for fireballs
var fireball = load("res://fireball.tscn")
var fireballs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _makeFireball(x, y, facing):
	var instance = fireball.instantiate()
	instance.xpos = x
	instance.ypos = y
	instance.set_direction(facing)
	instance.rotation_degrees = $Player1/Arrow_parent.rotation_degrees
	$"..".add_child(instance)
	fireballs.append(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Clock.get_child(1).rotation += delta*up
	#print($Clock.get_child(1).rotation)
	if ($Clock.get_child(1).rotation >= 6.283185):
		$Clock.get_child(1).rotation = 0
		$Player1._doAction()
		for Fireball in fireballs:
			Fireball._moveProjectile()



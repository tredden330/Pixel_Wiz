extends Node2D

var fireball = load("res://fireball.tscn")
var fireballs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addFireball(x, y, facing):
	var instance = fireball.instantiate()
	instance.xpos = x
	instance.ypos = y
	instance.direction = facing
	$"..".add_child(instance)
	fireballs.append(instance)

func resolveProjectileMoves():
	for Fireball in fireballs:
		if Fireball != null:
				Fireball._moveProjectile()

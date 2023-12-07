extends Node2D

var time = 0.0

var xlim = 9
var ylim = 5

#vars for fireballs
var fireball = load("res://fireball.tscn")
var fireballs = []

var gameStarted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _makeFireball(x, y, facing):
	var instance = fireball.instantiate()
	instance.xpos = x
	instance.ypos = y
	instance.direction = facing
	instance.rotation_degrees = $Player1/Arrow_parent.rotation_degrees
	$"..".add_child(instance)
	fireballs.append(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#game starts when server says so
	if gameStarted == true:
		time += delta
		$Clock.get_child(1).rotation = time
		#print($Clock.get_child(1).rotation)
		if ($Clock.get_child(1).rotation >= 6.283185):
			$Clock.get_child(1).rotation = 0
			#$Player1._doAction()
			for Fireball in fireballs:
				if Fireball != null:
					Fireball._moveProjectile()
					
			#send input to server
			if !multiplayer.is_server():
				$"Network Manager".serverMessage.rpc_id(1, "hi")



extends Node2D

var time = 0.0

var xlim = 9
var ylim = 5

var gameStarted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#game starts when server says so
	if gameStarted == true:
		time += delta
		$Clock.get_child(1).rotation = time
		#print($Clock.get_child(1).rotation)
		if ($Clock.get_child(1).rotation >= 6.283185):
			#print("tick")
			$Clock.get_child(1).rotation = 0
			
			$"Projectile Manager".resolveProjectileMoves()

func stopGame():
	gameStarted = false

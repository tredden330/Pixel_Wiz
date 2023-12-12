extends Node2D

var time = 0.0

var xlim = 20
var ylim = 10

var tiles = []
var tileMap = []

var floorTile = load("res://Scenes/floor.tscn")

var gameStarted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(xlim):
		for y in range(ylim):
			var instance = floorTile.instantiate()
			instance.position = Vector2(x*64, y*64)
			tiles.append(instance)
		tileMap.append(tiles)
			
			
	print(tileMap[1][1].position)
	for tiles in tileMap:
		for tile in tiles:
			$".".add_child(tile)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#game starts when server says so
	if gameStarted == true:
		
		time += delta
		$Clock.get_child(1).rotation = time

		if ($Clock.get_child(1).rotation >= 6.283185):
			
			$Clock.get_child(1).rotation = 0
			$"Projectile Manager".resolveProjectileMoves()

func stopGame():
	gameStarted = false
	$"Network Manager".player_models = []

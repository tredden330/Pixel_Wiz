extends Node2D

#tile dimenstions of room
var xSize = 1
var ySize = 1

#tile data
var tile = load("res://Scenes/floor.tscn")
var tileSize = 64
var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(xSize):
		for y in range(ySize):
			var newTile = tile.instantiate()
			newTile.position = Vector2(x*tileSize, y*tileSize)
			$".".add_child(newTile)
			tiles.append(newTile)
	#var instance = tile.instantiate()
	#$".".add_child(instance)
	$CollisionShape2D.shape.size = Vector2(xSize*tileSize, ySize*tileSize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

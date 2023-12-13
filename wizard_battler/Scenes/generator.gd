extends Node2D

var room = load("res://Scenes/room.tscn")
var rooms = []

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(4):
		generateRoom()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generateRoom():
	var instance = room.instantiate()
	instance.xSize = randi_range(1,4)
	instance.ySize = randi_range(1,4)
	instance.position = Vector2(randf_range(0,100), randf_range(0,100))
	print(instance)
	$".".add_child(instance)

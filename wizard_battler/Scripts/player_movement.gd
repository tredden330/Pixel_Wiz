extends Node2D

var speed = 3
var sprite2d
var fireball = load("res://fireball.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	print(get_children())
	
	var fireballs = []
	for i in range(200):
		var instance = fireball.instantiate()
		instance.position = Vector2(rng.randf_range(0.0, 1000.0),rng.randf_range(0.0, 500.0))
		fireballs.append(instance)
	
	for fireball in fireballs:
		add_child(fireball)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("up"):
		position.y -= speed
	if Input.is_action_pressed("down"):
		position.y += speed
	if Input.is_action_pressed("left"):
		position.x -= speed
	if Input.is_action_pressed("right"):
		position.x += speed
	
#func _input(event):
#	if event.is_action_pressed("move_up_1"):
#		print("my_action occurred!")

extends Sprite2D

var speed = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	print("initializing")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up_2"):
		position.y -= speed
	elif Input.is_action_pressed("move_down_2"):
		position.y += speed
	
func _input(event):
	if event.is_action_pressed("move_up_1"):
		print("my_action occurred!")

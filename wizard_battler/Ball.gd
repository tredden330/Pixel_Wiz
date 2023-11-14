extends Sprite2D

var speed = 5
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = rng.randf_range(-180.0, 180.0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 650 or position.y < 0:
		rotation *= -1
		
	if position.x <= 1:
		if abs($"../Left Bar".position.y - position.y) < 300:
			print('made it')
			rotation *= -1
		else:
			print("you lost!!!!")
	if position.x >= 1140:
		print(abs($"../Right Bar".position.y - position.y))
		if abs($"../Right Bar".position.y - position.y) < 300:
			rotation *= -1
		else:
			print("you lost!!!!")
			
	position.x += cos(rotation) * speed
	position.y += sin(rotation) * speed
			
	#print("ball position", position)



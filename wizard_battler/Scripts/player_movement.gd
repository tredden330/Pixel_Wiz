extends Node2D

var speed = 3
var sprite2d
var fireball = load("res://fireball.tscn")
var rng = RandomNumberGenerator.new()
var fireballs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var idleAnimation = $Fire_Idle
	var castingAnimation = $Fire_Casting
	
	if Input.is_action_pressed("up"):
		position.y -= speed
	if Input.is_action_pressed("down"):
		position.y += speed
	if Input.is_action_pressed("left"):
		position.x -= speed
	if Input.is_action_pressed("right"):
		position.x += speed
	if Input.is_action_pressed("fireball"):
		var instance = fireball.instantiate()
		instance.position = position
		$"../Floor".add_child(instance)
		fireballs.append(instance)
		
		idleAnimation.hide()
		castingAnimation.show()
		
		


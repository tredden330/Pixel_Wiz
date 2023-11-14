extends Node2D

var speed = 3
var sprite2d
var fireball = load("res://fireball.tscn")
var rng = RandomNumberGenerator.new()
var fireballs = []

var didCast = false
var cooldown = 1.0
var timer =  cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	print()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#fetch sprite2d 
	var idleAnimation = $Fire_Idle
	var castingAnimation = $Fire_Casting
	idleAnimation.visible = true
	castingAnimation.visible = false
	
	#monitor spell cooldown
	if didCast == true:
		timer -= delta
		if timer <= 0.0:
			didCast = false
			timer = cooldown
	
	#resolve inputs
	if Input.is_action_pressed("up"):
		position.y -= speed
	if Input.is_action_pressed("down"):
		position.y += speed
	if Input.is_action_pressed("left"):
		position.x -= speed
	if Input.is_action_pressed("right"):
		position.x += speed
	if Input.is_action_pressed("fireball") and didCast == false:
		print("casting")
		var instance = fireball.instantiate()
		instance.position = position
		$"..".add_child(instance)
		fireballs.append(instance)
		
		idleAnimation.hide()
		castingAnimation.show()
		didCast = true
	else:
		idleAnimation.show()
		castingAnimation.hide()	
		
	print(timer)


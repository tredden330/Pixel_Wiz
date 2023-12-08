extends Node2D



var action = null
var xlim = 9
var ylim = 5
var xpos = 0
var ypos = 0
var facing = Vector2(1, 0)

var idleAnimation
var castingAnimation

var actionRequested = false

# Called when the node enters the scene tree for the first time.
func _ready():
	idleAnimation = $Fire_Idle
	castingAnimation = $Casting_Animation
	idleAnimation.show()
	castingAnimation.hide()

#executes actions and movements
func _doAction(action, mouse):
	print(action, mouse)
	if (action == null):
		idleAnimation.show()
		castingAnimation.hide()
	elif (action == "up"):
		ypos -= 1
		idleAnimation.show()
		castingAnimation.hide()
	elif (action == "down"):
		ypos += 1
		idleAnimation.show()
		castingAnimation.hide()
	elif (action == "left"):
		xpos -= 1
		idleAnimation.show()
		castingAnimation.hide()
	elif (action == "right"):
		xpos += 1
		idleAnimation.show()
		castingAnimation.hide()
	elif (action == "fireball"):
		facing = calculateFacing(mouse)
		$"../Projectile Manager".addFireball(xpos, ypos, facing)
		idleAnimation.hide()
		castingAnimation.show()
		castingAnimation.play()
	position.x = (xpos * 128) + 64
	position.y = (ypos * 128) + 64
	action = null
	
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = (xpos * 128) + 64
	position.y = (ypos * 128) + 64
	#if this player is the one that controls this unit
	if name == str(multiplayer.get_unique_id()):
		
		#set action
		if Input.is_action_pressed("up"):
			action = "up"
		if Input.is_action_pressed("down"):
			action = "down"
		if Input.is_action_pressed("left"):
			action = "left"
		if Input.is_action_pressed("right"):
			action = "right"
		if Input.is_action_pressed("fireball"):
			action = "fireball"
		
		#if the server requested an action, give it
		if actionRequested == true:
			sendAction.rpc(multiplayer.get_unique_id(), action, get_viewport().get_mouse_position())
			action = null
			actionRequested = false
		
		#update directional arrow
		var player_location_minus_mouse = get_viewport().get_mouse_position() - position
		if abs(player_location_minus_mouse.x) > abs(player_location_minus_mouse.y):
			if (player_location_minus_mouse.x > 0):
				$Arrow_parent.rotation_degrees = 0
				facing = Vector2(1, 0)
			else:
				$Arrow_parent.rotation_degrees = 180
				facing = Vector2(-1, 0)
		else:
			if (player_location_minus_mouse.y > 0):
				$Arrow_parent.rotation_degrees = 90
				facing = Vector2(0, 1)
			else:
				$Arrow_parent.rotation_degrees = 270
				facing = Vector2(0, -1)
	else:
		$Arrow_parent.visible = false
		
@rpc("any_peer", "call_local", "reliable", 0)
func sendAction(id, action, mouse):
	$"../Network Manager".action_ids.append(id)
	$"../Network Manager".actions.append(action)
	$"../Network Manager".mouses.append(mouse)
	
func setActionRequest():
	actionRequested = true
	
func calculateFacing(mouse):
	var player_location_minus_mouse = mouse - position
	var face
	if abs(player_location_minus_mouse.x) > abs(player_location_minus_mouse.y):
		if (player_location_minus_mouse.x > 0):
			face = Vector2(1, 0)
		else:
			face = Vector2(-1, 0)
	else:
		if (player_location_minus_mouse.y > 0):
			face = Vector2(0, 1)
		else:
			face = Vector2(0, -1)
	return face
	

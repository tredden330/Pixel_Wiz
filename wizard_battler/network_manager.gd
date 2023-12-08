extends Node

#networking address info
@export var Address = "vm.thomasredden.com"
var port = 2049
var peer = ENetMultiplayerPeer.new()

var time = 0.0
var up = 8

#grab player scene
@export var player_char: PackedScene

var players = []
var player_models = []

var action_ids = []
var actions = []
var mouses = []

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
	if DisplayServer.get_name() == 'headless':          #this should only be true for the server
		print('i am server!!')
		var server = peer.create_server(port)
		if server != OK:
			print("hosting error: ", server)
		multiplayer.set_multiplayer_peer(peer)
		print("server made on port: ", port ," Waiting for players...")
		
	rng.seed = hash("Godot")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#send the time
	if multiplayer.is_server() and $"..".gameStarted:
		time += delta*up
		if time >= 6.283185:
			time = 0
			requestActions.rpc()
		declareTime.rpc(time)
		
		#resolve actions
		if len(action_ids) == len(players):
			#print("actions:: ids:", action_ids, " actions: ",actions, " mouses: ",mouses)
			resolveActions.rpc(action_ids, actions, mouses)
			action_ids = []
			actions = []
			mouses = []
			
			

func peer_connected(id):
	print("Player Connected: ", id)
	players.append(id)
	
func peer_disconnected(id):
	print("Player Disconnected: ", id)
	players.erase(id)
	print(players)
	if len(players) == 0:
		$"..".quitGame()
		time = 0.0
	

func connected_to_server():
	print("connected to server!")
	
func connection_failed():
	print("connection failed")
	
func join_button_pressed():
	peer = ENetMultiplayerPeer.new()
	print(Address)
	peer.create_client(Address, port)
	multiplayer.set_multiplayer_peer(peer)
	
func start_button_pressed():
	startGame.rpc()
	
@rpc("any_peer", "call_local", "reliable", 0)
func startGame():
	$"..".gameStarted = true
	$"../UI/Start".visible = false
	if multiplayer.is_server():
		print("sending player messages: ", players)
		var randoms = []
		for player in players:
			randoms.append(rng.randi_range(0,9))
		setupPlayers.rpc(players, randoms)
		
@rpc("any_peer", "call_local", "reliable", 0)
func setupPlayers(players, locations):
	print(players)
	for index in len(players):
		print(index)
		var instance = player_char.instantiate()
		$"..".add_child(instance)
		instance.name = str(players[index])
		instance.xpos = locations[index]
		instance.ypos = locations[index]
		player_models.append(instance)
		

@rpc("any_peer", "call_local", "reliable", 0)
func declareTime(time):
	$"..".time = time

@rpc("any_peer", "call_local", "reliable", 0)
func requestActions():
#	print("action requested")
	for player in player_models:
#		print(player.name)
		player.setActionRequest()
		
@rpc("any_peer", "call_local", "reliable", 0)
func resolveActions(action_ids, actions, mouses):
	for index in len(action_ids):
		get_node(str("../" + str(action_ids[index])))._doAction(actions[index], mouses[index])
	$"../Projectile Manager".resolveProjectileMoves()

extends Node

#networking address info
@export var Address = "vm.thomasredden.com"
var port = 2049
var peer = ENetMultiplayerPeer.new()

var time = 0.0
var up = 4

#grab player scene
@export var player_char: PackedScene

var players = []

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#send the time
	if multiplayer.is_server() and $"..".gameStarted:
		time += delta*up
		if time >= 6.283185:
			time = 0
		declareTime.rpc(time)
		#print_once_per_client.rpc()

func peer_connected(id):
	print("Player Connected: ", id)
	players.append(id)
	
func peer_disconnected(id):
	print("Player Disconnected: ", id)

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
	
@rpc("any_peer", "call_remote", "reliable", 0)
func serverMessage(action):
	print("Client Action: ", action)
	
@rpc("any_peer", "call_local", "reliable", 0)
func startGame():
	$"..".gameStarted = true
	if multiplayer.is_server():
		print("sending player messages")
		declarePlayers.rpc(20)
		
@rpc
func declarePlayers(message):
	print(message)
	
@rpc
func declareTime(time):
	$"..".time = time
extends Control

@export var Address = "127.0.0.1"

var peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
	if DisplayServer.get_name() == 'headless':
		print('i am server!!')
		var server = peer.create_server(2010, 3)
		if server != OK:
			print("hosting error: " + server)
		multiplayer.set_multiplayer_peer(peer)
		print("Waiting for players...")
		
		
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func peer_connected(id):
	print("Player Connected: " + str(id))
	
func peer_disconnected(id):
	print("Player Disconnected: " + id)

func connected_to_server():
	print("connected to server!")
	
func connection_failed():
	print("connection failed")

func _on_join_button_down():
	print("join button down")
	peer = ENetMultiplayerPeer.new()
	peer.create_client("192.168.0.255", 2010)
	multiplayer.set_multiplayer_peer(peer)

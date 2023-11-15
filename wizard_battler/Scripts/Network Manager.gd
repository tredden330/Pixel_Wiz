extends Node

var peer = ENetMultiplayerPeer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	if DisplayServer.get_name() == 'headless':
		print('i am server!!')
		peer.create_server(2010, 3)
		multiplayer.multiplayer_peer = peer
	else:
		print('I am client!!')
		peer.create_client('vm.thomasredden.com', 2010)
		multiplayer.multiplayer_peer = peer
		print(multiplayer.get_unique_id())
		
	#print(DisplayServer.get_name())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


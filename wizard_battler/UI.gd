extends Control

func _on_join_button_down():
	print("join button down")
	$"../Network Manager".join_button_pressed()
	$Start.visible = true
	$Join.visible = false

func _on_start_button_down():
	$"../Network Manager".start_button_pressed()
	$Start.visible = false

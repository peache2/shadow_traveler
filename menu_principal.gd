extends Node2D


func _on_button_pressed() -> void:
	$Clicknewgame.play()
	await $Clicknewgame.finished
	get_tree().change_scene_to_file("res://pantalla_de_carga.tscn")

	


func _on_button_2_pressed() -> void:
	get_tree().quit()

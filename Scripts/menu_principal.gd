extends Node2D

func _on_button_pressed() -> void:
	$Clicknewgame.play()
	get_tree().change_scene_to_file("res://Scenes/pantalla_de_carga.tscn")
	GameManager.current_health = GameManager.max_health

func _on_button_2_pressed() -> void:
	get_tree().quit()

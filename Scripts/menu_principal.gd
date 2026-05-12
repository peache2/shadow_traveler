extends Node2D

func _on_button_pressed() -> void:
	$PLAY.disabled = true
	$Clicknewgame.play()
	
	await get_tree().create_timer(1).timeout
	
	GameManager.current_health = GameManager.max_health
	get_tree().change_scene_to_file("res://Scenes/pantalla_de_carga.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

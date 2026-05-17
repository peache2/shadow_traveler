extends Node2D

func _ready():
	await get_tree().process_frame

	if has_node("/root/GameManager"):
		var gm = get_node("/root/GameManager")
		if gm.has_method("reset"):
			gm.reset()

func _on_button_pressed() -> void:
	if not is_inside_tree():
		return

	$PLAY.disabled = true
	$Clicknewgame.play()

	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/pantalla_de_carga.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")

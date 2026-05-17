extends Node

@onready var slider_volumen = $CanvasLayer/HSlider

func _ready():
	var volumen_actual_db = AudioServer.get_bus_volume_db(0)
	slider_volumen.value = db_to_linear(volumen_actual_db)
	slider_volumen.value_changed.connect(_on_volumen_changed)

func _on_volumen_changed(valor: float):
	AudioServer.set_bus_volume_db(0, linear_to_db(valor))
	
	if valor <= 0.05:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu_principal.tscn")

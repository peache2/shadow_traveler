extends Node2D

func _on_area_2d_body_entered(_body: Node2D) -> void:
	$Camera2D2.enabled = true
	$Camera2D.enabled = false
	$CrisisFight.playing = true
	$Menu.playing = false

extends Node2D

func _on_zone_2_body_entered(_body: Node2D) -> void:
	$Camera2D2.enabled = true
	$Camera2D.enabled = false
	$CrisisFight.playing = true
	$Test.playing = true


func _on_zone_1_body_entered(_body: Node2D) -> void:
	$Camera2D.enabled = true
	$Camera2D3.enabled = false

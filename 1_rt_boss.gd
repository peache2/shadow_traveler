extends Node2D

func _on_zone_2_body_entered(_body: Node2D) -> void:
	$Camera2D2.enabled = true
	$Camera2D.enabled = false
	$Camera2D3.enabled = false
	$CrisisFight.playing = true


func _on_zone_1_body_entered(_body: Node2D) -> void:
	$Camera2D.enabled = true
	$Camera2D3.enabled = false


func _on_timer_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/letters, "modulate:a", 0.0, 0.5)
	tween.tween_callback($CanvasLayer/letters.queue_free)

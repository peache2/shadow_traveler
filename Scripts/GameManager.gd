extends Node

signal health_changed(current_health)

var max_health: float = 3.0
var current_health: float = 3.0

var bosses_total: int = 2
var bosses_dead: int = 0

func take_damage(amount: float):
	current_health -= amount
	current_health = max(0, current_health)
	health_changed.emit(current_health)

func boss_died():
	bosses_dead += 1

	if bosses_dead >= bosses_total:
		get_tree().change_scene_to_file("res://Scenes/final_screen.tscn")

func reset():
	current_health = max_health
	bosses_dead = 0

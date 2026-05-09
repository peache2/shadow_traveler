extends Area2D

@export var enemy_scene: PackedScene
@onready var marker_2d = $ColiderSpawn/Marker2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		spawn_enemy()
		queue_free()

func spawn_enemy():
	var enemy_instance = enemy_scene.instantiate()
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = marker_2d.global_position
	$"../CrisisFight".play()
	$"../Suspenseloop".stop()

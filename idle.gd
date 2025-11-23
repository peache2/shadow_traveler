extends State
 
@onready var collision = $"../../PlayerDetect/CollisionShape2D"
@onready var progress_bar = owner.find_child("ProgressBar")
 
 
var player_entered: bool = false:
	set(value):
		player_entered = value
		collision.set_deferred("disabled", value)
		progress_bar.set_deferred("visible",value)
 
 
func _on_player_detect_body_entered(_body: Node2D) -> void:
	player_entered = true
 
func transition():
	if player_entered:
		get_parent().change_state("Follow")

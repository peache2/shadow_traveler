extends Area2D

var direction: Vector2 = Vector2.ZERO
var speed: float = 400.0

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(1.0)  
	queue_free()

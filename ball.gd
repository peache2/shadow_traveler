extends Area2D

@export var speed = 400
var direction = 1

func _ready():
	if direction == -1:
		$AnimatedSprite2D.flip_h = true

func _process(delta):
	position.x += speed * direction * delta

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(1)
		queue_free()
	elif body.is_in_group("Player"):
		pass
	else:
		queue_free()

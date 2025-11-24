extends Area2D

var direction: Vector2 = Vector2.RIGHT
var speed = 700

func _physics_process(delta):
	position += direction.normalized() * speed * delta

func _on_body_entered(body):
	body.take_damage()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

extends CharacterBody2D

@export var max_health: float = 10.0
var health: float = max_health

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite = $Sprite

var direction: Vector2

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	set_physics_process(true)

func _process(_delta):
	if player:
		direction = player.global_position - global_position
		animated_sprite.flip_h = direction.x < 0

func _physics_process(_delta):
	if player:
		velocity = direction.normalized() * 40
		move_and_slide()

func take_damage(amount: float):
	health -= amount
	print("Vida del minion:", health, "/", max_health)


	flash_red()

	if health <= 0:
		queue_free()

func flash_red():
	animated_sprite.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.15).timeout
	animated_sprite.modulate = Color(1, 1, 1)

func _on_damage_player_area_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(0.5)

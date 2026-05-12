extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animated_sprite = $AnimatedSprite2D

var direction : Vector2
var puede_hacer_daño : bool = false

func _ready():
	if not player:
		player = get_tree().get_first_node_in_group("Player")
	
	await get_tree().create_timer(0.5).timeout
	puede_hacer_daño = true

func _process(_delta):
	if player:
		direction = player.global_position - global_position
		animated_sprite.flip_h = direction.x < 0

func _physics_process(_delta):
	if player:
		velocity = direction.normalized() * 60
		move_and_slide()



func _on_damage_player_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("take_damage"):
			body.take_damage(0.5) 
		

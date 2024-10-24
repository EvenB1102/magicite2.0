extends Area2D

var bullet_distance = 0
var FIREBALL = preload("res://scenes/fireball.tscn")

func _physics_process(delta: float) -> void:
	const SPEED = 100
	const RANGE = 500
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	bullet_distance += SPEED * delta
	if bullet_distance > RANGE:
		queue_free()
		
		
# function for adding follow cursor fireballs
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			emit_signal(FIREBALL, rotation, position)
			
func _process(delta):
	look_at(get_global_mouse_position())
	
func _on_player_shoot(bullet, direction, location):
	var b = FIREBALL.instance()
	add_child(b)
	b.rotation = direction
	b.position = location
	b.velocity = b.velocity.rotated(direction)

#func _on_body_entered(body: Node2D) -> void:
#	queue_free()
#	if body.has_method("take_damage"):
#		body.take_damage()

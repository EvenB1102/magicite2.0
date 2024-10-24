extends CharacterBody2D


signal fire(bullet, direction, location)
const SPEED = 130.0
const JUMP_VELOCITY = -250.0
@onready var animation_play = $AnimatedSprite2D
var is_attacking = false



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# adds the animation idle and chaning character sprite horizontaly when chaning direction
	if velocity.x == 0 and is_attacking == false and animation_play.is_playing() == false:
		animation_play.play("idle")
	else:
		if is_on_floor() and is_attacking == false and velocity.x  > 0:
			animation_play.play("run")
		if velocity.x > 0:
			animation_play.flip_h = false
		elif velocity.x < 0:
			animation_play.flip_h = true		
		
		if Input.is_action_just_pressed("click"):
			shoot()

	attack()
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
		
	
func attack():
	if Input.is_action_just_pressed("click"):
		is_attacking = true
		animation_play.play("attack")
	else :
		is_attacking = false

func shoot():
	const FIREBALL = preload("res://scenes/fireball.tscn")
	var new_fireball = FIREBALL.instantiate()
	new_fireball.global_position = %shootingpoint.global_position
	new_fireball.global_rotation = %shootingpoint.global_rotation
	%shootingpoint.add_child(new_fireball)
	

	
	
	
	
	
		

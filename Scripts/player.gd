extends CharacterBody2D
class_name Player

# Anims
@onready var normal_form_anims: AnimatedSprite2D = $Animations/NormalFormAnims
@onready var crow_form_anims: AnimatedSprite2D = $Animations/CrowFormAnims

#Collisions
@onready var crow_collision: CollisionShape2D = $CrowCollision
@onready var normal_collision: CollisionShape2D = $NormalCollision

@onready var CoyoteTimer = $CoyoteTimer
@onready var JumpBufferTimer = $JumpBufferTimer

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

@export var speed = 20.0
@export var jump_height : float = 40.0
@export var jump_time_to_peak : float = 0.25
@export var jump_time_to_descent : float = 0.19

@export var dash_speed = 50.0
var dashing = false
var can_dash = true

@export var speed_multipilier = 30
var direction = 0

@export var FLAP_SPEED : int = 400

func _physics_process(delta):

	#👻REGULAR FORM
	if $"Radial Menu/UI".form == "None" or $"Radial Menu/UI".form == "none":
		normal_collision.disabled = false
		crow_collision.disabled = true
		update_animation()
		for i in $Animations.get_children():
			if i.name == "NormalFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		speed = 10
		velocity.y += gravityget() * delta
		
		if Input.is_action_just_pressed("dash") and can_dash and GlobalVars.dash == true:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$DashCooldown.start()

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("move_left", "move_right")
		if GlobalVars.movement_jump == true:
			if direction:
				if dashing:
					velocity.x = direction * dash_speed * speed_multipilier
				else:	
					velocity.x = direction * speed * speed_multipilier
			else:
				velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
		
		if direction < 0:
			normal_form_anims.flip_h = false
		elif direction > 0:
			normal_form_anims.flip_h = true
			
		var was_on_floor = is_on_floor()
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and GlobalVars.movement_jump == true:
			JumpBufferTimer.start()
			
		if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped():
			velocity.y = jump_velocity

		move_and_slide()
		
		if was_on_floor and not is_on_floor():
			CoyoteTimer.start()
			

	#🐦‍⬛ CROW TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 1":
		crow_collision.disabled = false
		normal_collision.disabled = true
		update_animation()
		for i in $Animations.get_children():
			if i.name == "CrowFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		direction = Input.get_axis("move_left", "move_right")
		speed = 10
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			crow_form_anims.play("Flap")
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying
	
	#🕯️MOTH TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 2" and GlobalVars.unlocked == true:
		for i in $Animations.get_children():
			if i.name == "MothFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		direction = Input.get_axis("move_left", "move_right")
		speed = 6
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying
	
	#🦅VULTURE TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 3" and GlobalVars.unlocked == true:
		for i in $Animations.get_children():
			if i.name == "VultureFormAnims":
				i.visible = true
			else:
				i.visible = false
				
		direction = Input.get_axis("move_left", "move_right")
		speed = 3
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		velocity.y += gravityget() * delta
			
		if Input.is_action_just_pressed("jump"):
			velocity.y = -FLAP_SPEED
		
		move_and_slide()
		
		if not is_on_floor() and velocity.y > 0:
			pass #falling
		elif not is_on_floor() and velocity.y < 0:
			pass #flying
	
	#🌹FLOWER TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 4" and GlobalVars.unlocked == true:
		for i in $Animations.get_children():
			if i.name == "FlowerFormAnims":
				i.visible = true
			else:
				i.visible = false
				
		velocity.y += gravityget() * delta
	
	#⌛HOURGLASS TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 5" and GlobalVars.unlocked == true:
		
		for i in $Animations.get_children():
			if i.name == "HourglassFormAnims":
				i.visible = true
			else:
				i.visible = false
				
	else:
		normal_collision.disabled = false
		crow_collision.disabled = true
		for i in $Animations.get_children():
			if i.name == "NormalFormAnims":
				i.visible = true
			else:
				i.visible = false
		
		speed = 10
		velocity.y += gravityget() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and GlobalVars.movement_jump == true:
			JumpBufferTimer.start()
			
		if Input.is_action_just_pressed("dash") and can_dash and GlobalVars.dash == true:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$DashCooldown.start()
			
		if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("move_left", "move_right")
		if GlobalVars.movement_jump == true:
			if direction:
				if dashing:
					velocity.x = direction * dash_speed * speed_multipilier
				else:
					velocity.x = direction * speed * speed_multipilier
			else:
				velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		var was_on_floor = is_on_floor()

		move_and_slide()
		
		if was_on_floor and not is_on_floor():
			CoyoteTimer.start()
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

# dashing
func _on_dash_timer_timeout() -> void:
	dashing = false

func _on_dash_cooldown_timeout() -> void:
	can_dash = true
	
func update_animation():
#👻REGULAR FORM
	if $"Radial Menu/UI".form == "None" or $"Radial Menu/UI".form == "none":
		if direction != 0:
			normal_form_anims.flip_h = direction > 0
			
		if dashing:
			normal_form_anims.play("Dash")
		elif not is_on_floor():
			normal_form_anims.play("jump" if velocity.y < 0 else "Fall")
		elif direction != 0:
			normal_form_anims.play("walk")
		else:
			normal_form_anims.play("idle")

	#🐦‍⬛ CROW TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 1":
		if direction != 0:
			crow_form_anims.flip_h = direction > 0
		
		if not is_on_floor():
			crow_form_anims.play("Flap" if velocity.y < 0 else "Fall")
		elif direction != 0:
			crow_form_anims.play("Walk")
		else:
			crow_form_anims.play("Idle")			
	
	#🕯️MOTH TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 2" and GlobalVars.unlocked == true:
		pass
	
	#🦅VULTURE TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 3" and GlobalVars.unlocked == true:
		pass
	
	#🌹FLOWER TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 4" and GlobalVars.unlocked == true:
		pass
	
	#⌛HOURGLASS TRANSFORMATION
	elif $"Radial Menu/UI".form == "Transform 5" and GlobalVars.unlocked == true:
		pass

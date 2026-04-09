extends CharacterBody2D

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

func _physics_process(delta):
	#Regular Form
	if $"Radial Menu/UI".form == "None" or $"Radial Menu/UI".form == "none":
		self.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
		velocity.y += gravityget() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump"):
			JumpBufferTimer.start()
			
		if Input.is_action_just_pressed("dash") and can_dash:
			dashing = true
			can_dash = false
			$DashTimer.start()
			$DashCooldown.start()
			
		if	(is_on_floor() or not CoyoteTimer.is_stopped()) and not JumpBufferTimer.is_stopped():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		direction = Input.get_axis("move_left", "move_right")
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

	elif $"Radial Menu/UI".form == "Transform 1":
		self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
		
		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed * speed_multipilier
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multipilier)
			
		move_and_slide()
	
	if Input.is_action_just_pressed("transformation"):
		$SelectionWheel.show()
	elif Input.is_action_just_released("transformation"):	
		$SelectionWheel.Close()
	
func gravityget() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

# dashing
func _on_dash_timer_timeout() -> void:
	dashing = false
func _on_dash_cooldown_timeout() -> void:
	can_dash = true
	
	

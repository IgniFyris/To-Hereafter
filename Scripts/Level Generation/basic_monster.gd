extends CharacterBody2D
class_name BasicMonster

signal player_inside
signal player_outside

var arrowsContainer: PackedScene = preload("uid://hedujnigma4w")
@export var arrowConYPos : float
@onready var MonsChecker = $MonsChecker
@onready var KillZone = $Killzone
@onready var mons_anims: AnimatedSprite2D = $MonsAnims

var arrowPicRes = load("uid://cokccv0240pwm")
var arrowPicResH = load("uid://drk7gt8ct3hpf")

#Arrow Configuration
var arrowCon
var arrowRots
var keys = []
var input = 1

#Movement Configuration
const GRAVITY : float = 300.0
@export var speed : float = 30.0
@onready var WallDetectionRay = $WallDetectionRay
@onready var WallDetectionRay2 = $WallDetectionRay2
@onready var LedgeDetectionRay = $LedgeDetectionRay
var direction : float = 1.0

var collided
var playerIn = false

func _ready() -> void:
	
	set_process_input(false)

func _physics_process(delta: float) -> void:
	movement(delta)
	update_direction()
	update_animation()
	
	move_and_slide()
	
func movement(delta : float):
	velocity.y += GRAVITY * delta
	velocity.x = speed * direction
	
func update_animation():
	if direction != 0:
		mons_anims.flip_h = direction > 0
		
	elif direction != 0:
		mons_anims.play("Walk")
	elif playerIn == true:
		mons_anims.play("Attacked")
	else:
		mons_anims.play("Idle")

func update_direction():
	if not WallDetectionRay.is_colliding() and LedgeDetectionRay.is_colliding() and not WallDetectionRay2.is_colliding():
		return
		
	direction *= -1.0
	
	var WallDirectionRayPos : Vector2 = Vector2(WallDetectionRay.target_position.x * -1, WallDetectionRay.target_position.y)
	
	WallDetectionRay.target_position = WallDirectionRayPos
	
	var WallDirectionRay2Pos : Vector2 = Vector2(WallDetectionRay2.target_position.x * -1, WallDetectionRay2.target_position.y)
	
	WallDetectionRay2.target_position = WallDirectionRay2Pos
	
	collided = LedgeDetectionRay.get_collider()
	if collided is not BasicMonster:
		var LedgeDirectionRayPos : Vector2 = Vector2(LedgeDetectionRay.position.x * -1, LedgeDetectionRay.position.y)
		
		LedgeDetectionRay.position = LedgeDirectionRayPos
	
func _input(event: InputEvent) -> void:
	if input == 1:
		if event is InputEventKey and event.pressed:
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[0]:
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicResH
					input = 2
				else:
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
	elif  input == 2:
		if event is InputEventKey and event.pressed:
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[1]:
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicResH
					input = 3
				else:
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
					input = 1
	elif  input == 3:
		if event is InputEventKey and event.pressed:
			if not event.echo:
				if OS.get_keycode_string(event.keycode) == keys[2]:
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicResH
					kill_self()
				else:
					arrowCon.arrow1Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow2Container.get_child(0).texture_normal = arrowPicRes
					arrowCon.arrow3Container.get_child(0).texture_normal = arrowPicRes
					input = 1

func _on_killzone_body_entered(body: Node2D) -> void:
	if body is Player:
		playerIn = true
		player_inside.emit()
		arrowCon = arrowsContainer.instantiate()
		add_child(arrowCon)
		arrowRots = arrowCon.arrowRots
		
		arrowCon.position.y = arrowConYPos
		
		for i in arrowRots:
			if i == 0.0:
				keys.append("Right")
			elif i == 90.0:
				keys.append("Down")
			elif i == -180.0:
				keys.append("Left")
			elif i == -90.0:
				keys.append("Up")
				
		input = 1

		set_process_input(true)

func _on_killzone_body_exited(body: Node2D) -> void:
	if body is Player:
		playerIn = false
		player_outside.emit()
		Engine.time_scale = 1
		if arrowCon:
			arrowCon.queue_free()
		keys.clear()
		set_process_input(false)

func kill_self():
	if get_parent().SanityBar.value + 40 > 500:
		get_parent().SanityBar.value = 500
	elif get_parent().SanityBar.value + 40 < 500:
		get_parent().SanityBar.value += 40 
	self.queue_free()

func _on_other_mons_checker_body_entered(body: Node2D) -> void:
	if body is BasicMonster and not self:
		self.queue_free()

func _on_mons_checker_body_entered(body: Node2D) -> void:
	if body is BasicMonster:
		self.queue_free()

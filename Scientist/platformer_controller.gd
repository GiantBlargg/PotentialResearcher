extends CharacterBody2D

@export var ascend_time: float = 0.5;
@export var fall_time: float = 0.35;
@export var jump_height: float = 2000;

@export var max_speed: float = 3000;
@export var speedup_time: float = 0.2;

var jump_gravity: float;
var fall_gravity: float;
var jump_vel: float;

var max_hor_accel: float;

var carrying: Carriable
@onready var pickupArea = get_node("PickupArea")
@onready var carryPoint = get_node("CarryPoint")

func _ready():
	config_physics()
	
func config_physics():
	jump_gravity = 2 * jump_height / (ascend_time * ascend_time)
	jump_vel = -2 * jump_height / ascend_time
	fall_gravity = 2 * jump_height / (fall_time * fall_time)
	max_hor_accel = max_speed / speedup_time

func _physics_process(delta):
	if Input.is_action_pressed("Jump") and velocity.y < 0:
		velocity.y += jump_gravity * delta
	else:
		velocity.y += fall_gravity * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_vel

	var direction: float = Input.get_axis("Left", "Right")
	var target_speed = direction * max_speed;
	var hor_accel = max_hor_accel * delta
	velocity.x += clamp(target_speed - velocity.x, -hor_accel, hor_accel)
	
	if Input.is_action_just_pressed("Pick Up"):
		if (carrying == null):
			for i in pickupArea.get_overlapping_bodies():
				if i.has_method("carry"):
					carrying = i
					carrying.carry(carryPoint)
					break
		else:
			carrying.carry(null)
			carrying = null

	move_and_slide()

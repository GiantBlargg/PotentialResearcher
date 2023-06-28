extends RigidBody2D

@export var capacity: float
var value: float

var charging: bool
var discharging: bool

var anim: AnimationPlayer

func set_charging(v:bool):
	charging = v
	
func set_discharging(v:bool):
	discharging = v

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("AnimationPlayer")
	anim.set_current_animation("Charging")
	anim.pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta:float):
	if charging:
		value += delta
	if discharging:
		value -= delta

	if value >= capacity:
		value = capacity
	if value <= 0:
		value = 0
		
	anim.seek(value/capacity, true)
	

var carrier:Node2D = null

func carry(_c:Node2D):
	carrier = _c
	set_sleeping(false)

func _integrate_forces(state):
	if carrier:
		state.transform = carrier.global_transform
		state.linear_velocity = Vector2(0,0)

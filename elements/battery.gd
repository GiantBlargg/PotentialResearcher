extends RigidBody2D

@export var capacity: float
var value: float

var charging: bool
var discharging: bool

var fill_meter: Sprite2D
var fill_width: float

func set_charging(v:bool):
	charging = v
	
func set_discharging(v:bool):
	discharging = v

# Called when the node enters the scene tree for the first time.
func _ready():
	fill_meter = get_node("FillMeter")
	fill_width = fill_meter.scale.x

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
		
	fill_meter.scale.x = fill_width * (value/capacity)
		
		
@export var debug: bool = false
var reposition: bool = false
var new_pos:Vector2

func _input(event):
	if debug:
		if event.get_class() == "InputEventMouseButton":
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					reposition = true
					new_pos = event.position
					set_sleeping(false)

func _integrate_forces(state):
	if reposition:
		reposition = false
		state.transform.origin = new_pos
		state.linear_velocity = Vector2(0,0)

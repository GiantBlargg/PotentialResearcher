extends Carriable

@export var charging_time: float = 1
@export var discharging_time: float = 1
@export var value: float = 0

var charging: bool
var discharging: Discharger

var empty: bool

var anim: AnimationPlayer

func set_charging(v:bool):
	charging = v
	
func set_discharging(v):
	if !empty && discharging != null:
		discharging.stop_power.emit()
	discharging = v
	if !empty && discharging != null:
		discharging.send_power.emit()
	

# Called when the node enters the scene tree for the first time.
func _ready():
	anim = get_node("AnimationPlayer")
	anim.set_current_animation("Charging")
	anim.pause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta:float):
	if charging:
		value += delta * (discharging_time / charging_time)
	if discharging != null:
		value -= delta

	if value >= discharging_time:
		value = discharging_time
	if value <= 0:
		value = 0
		if !empty && discharging != null:
			discharging.stop_power.emit()
		empty = true
	else:
		if empty && discharging != null:
			discharging.send_power.emit()
		empty = false
		
	anim.seek(value/discharging_time, true)
	

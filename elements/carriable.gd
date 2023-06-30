extends RigidBody2D

class_name Carriable

var carrier:Node2D = null

func carry(_c:Node2D):
	carrier = _c
	set_sleeping(false)

func _integrate_forces(state):
	if carrier:
		state.transform = carrier.global_transform
		state.linear_velocity = Vector2(0,0)

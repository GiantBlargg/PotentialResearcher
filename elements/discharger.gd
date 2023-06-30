extends Carriable

class_name Discharger

signal send_power
signal stop_power

func _on_body_entered(body):
	if body.has_method("set_discharging"):
		body.set_discharging(self)


func _on_body_exited(body):
	if body.has_method("set_discharging"):
		body.set_discharging(null)

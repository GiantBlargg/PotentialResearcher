extends Area2D

func _on_body_entered(body):
	if body.has_method("set_charging"):
		body.set_charging(true)
		

func _on_body_exited(body):
	if body.has_method("set_charging"):
		body.set_charging(false)

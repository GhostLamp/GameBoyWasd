extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is PorcoChar:
		body.pedras += 1
		queue_free()

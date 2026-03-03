extends CharacterBody2D


func _physics_process(delta: float) -> void:
	velocity = 1200*Vector2.RIGHT
	
	
	var colisao = move_and_collide(velocity * delta)
	if colisao:
		if colisao.get_collider().has_method("pedrada"):
			colisao.get_collider().pedrada()
		queue_free()

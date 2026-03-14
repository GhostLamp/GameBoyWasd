extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CoioteInimigo:
		var end_screen: Node2D = $"../endScreen"
		var game_elements: Node2D = $"../gameElements"
		var fade_out: ColorRect = $"../fadeOut"
		
		fade_out.visible = true
		game_elements.queue_free()
		
		var tween:Tween = get_tree().create_tween()
		tween.tween_property(fade_out,"size",Vector2(fade_out.size.x,0),0.5)
		tween.parallel().tween_property(fade_out,"position", fade_out.position+Vector2(0,fade_out.size.y/2),0.5)
		tween.tween_property(end_screen,"visible",true,1)
		

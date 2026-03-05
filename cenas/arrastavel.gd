extends Button

var snap = 32
var off:Vector2 = Vector2.ZERO
var arrastando:bool = false

func _physics_process(delta: float) -> void:
	if !arrastando:
		return
	
	var mouse = get_global_mouse_position() + off
	global_position = Vector2(snapped(mouse.x,snap),snapped(mouse.y,snap))


func _on_button_down() -> void:
	arrastando = true
	off = global_position - get_global_mouse_position()


func _on_button_up() -> void:
	arrastando = false

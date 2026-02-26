extends Node2D
class_name MainScene
@onready var game_boy_manager: Node2D = $GameBoyManager
@onready var camera_2d: Camera2D = $Camera2D
@onready var v_box_container: VBoxContainer = $canvas/VBoxContainer

var items:Dictionary = {}


func adicionar_item(item:String):
	var nova_label = Label.new()
	
	nova_label.text = item
	
	v_box_container.call_deferred("add_child",nova_label)
	
	items.get_or_add(item,nova_label)

func usar_item(item:String,remover:bool) -> bool:
	if items[item]:
		if remover:
			items[item].queue_free()
			items.erase(item)
		
		return true
	
	return false


func _ready() -> void:
	gameBoy_deactivate()

func gameBoy_activate():
	camera_2d.position = game_boy_manager.position

func gameBoy_deactivate():
	camera_2d.position = Vector2.ZERO

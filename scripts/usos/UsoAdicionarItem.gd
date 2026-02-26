extends Uso

@export var item:String

func uso():
	var manager:MainScene = get_tree().current_scene
	manager.adicionar_item(item)

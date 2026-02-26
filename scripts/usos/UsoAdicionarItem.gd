extends Uso

@export var item:String

# pega a cena principal e adiciona um item
func uso():
	var manager:MainScene = get_tree().current_scene
	manager.adicionar_item(item)

extends HBoxContainer

@export var resposta:Array[Color]

func checarCodigo():
	for i in get_children().size():
		var child:ColorRect = get_children()[i]
		if child.color != resposta[i]:
			return false
	
	return true

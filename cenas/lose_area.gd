extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CoioteInimigo:
		get_parent().deleter_jogo()
	
		var main_node: MainScene = $"../../.."
		var pausa_menu: CenaGameboy = $"../../PausaMenu"
		
		main_node.troca_devagar()

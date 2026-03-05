extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CoioteInimigo:
		var main_node: MainScene = $"../../.."
		var pausa_menu: CenaGameboy = $"../../PausaMenu"
		
		main_node.troca_devagar()
		get_parent().deleter_jogo()

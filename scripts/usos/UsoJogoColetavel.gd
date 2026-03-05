extends Uso

@export var jogo:PackedScene

func uso():
	var main:MainScene = get_tree().current_scene
	
	var novojogo:CenaGameboy = jogo.instantiate()
	
	main.game_boy_manager.call_deferred("add_child",novojogo)
	

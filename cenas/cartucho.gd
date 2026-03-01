class_name Cartucho
extends Button

@export var jogo:CenaGameboy



func _on_pressed() -> void:
	var main:MainScene = $"../.."
	
	main.gameBoy_trocar(jogo)

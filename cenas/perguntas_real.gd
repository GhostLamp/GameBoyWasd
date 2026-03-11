class_name PerguntasReal
extends VBoxContainer

@export var alvo:Node
var pecas:Array = []
var posicoes:Array = []
@export var resposta:Array[int]

func _ready() -> void:
	add_to_group("perguntasReal")
	
	for i in get_children():
		pecas.append(i)

func checarSolução():
	if resposta == posicoes:
		alvo.visible = false
	else:
		alvo.visible = true

func set_resposta(nova_resposta:Array):
	posicoes = nova_resposta
	for i in nova_resposta.size():
		move_child(pecas[nova_resposta[i]],i)

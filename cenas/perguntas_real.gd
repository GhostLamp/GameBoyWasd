class_name PerguntasReal
extends VBoxContainer

@export var alvo:Node
var pecas:Array = []
var posicoes:Array = []
@export var resposta:Array[int]

func _ready() -> void:
	add_to_group("perguntasReal")
	
	pecas = get_children()

func checarCodigo():
	if resposta == posicoes:
		return true
	return false

func set_resposta(nova_resposta:Array):
	posicoes = nova_resposta
	
	
	for i in nova_resposta.size():
		move_child(pecas[nova_resposta[i]],i)
	

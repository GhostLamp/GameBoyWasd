class_name EscorregaReal
extends Node2D

@export var passo:int
@export var offset:Vector2 = Vector2(-48,-48)
@export var alvo:CanvasItem
var pecas:Array = []
var posicoes:Array[Vector2]
@export var resposta:Dictionary

func _ready() -> void:
	add_to_group("escorregaReal")
	
	for i in get_children():
		pecas.append(i)

func checarSolução():
	for key in resposta.keys():
		if posicoes[key] != resposta[key]:
			alvo.visible = true
			return 
	
	alvo.visible = false

func set_peca(alvo:int, posicao:Vector2):
	var peca = pecas[alvo]
	peca.position = posicao*passo +offset
	if posicoes.size() >= alvo+1:
		posicoes[alvo] = posicao
		checarSolução()
	else:
		posicoes.insert(alvo,posicao)

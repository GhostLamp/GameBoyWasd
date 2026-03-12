class_name EscorregaReal
extends Node2D

@export var passo:int
@export var offset:Vector2 = Vector2(-48,-48)
@export var alvo:CanvasItem
var pecas:Array = []
var posicoes:Array[Vector2]
@export var resposta:Array[Array] = [[],[],[],[],[],[],[],[]]

func _ready() -> void:
	add_to_group("escorregaReal")
	pecas = get_children()
	
	for i in resposta.size():
		if resposta[i].size() == 0:
			pecas[i].visible = false

func checarCodigo():
	for i in resposta.size():
		if resposta[i].size() > 0:
			if !resposta[i].has(posicoes[i]):
				return false
	
	return true

func set_peca(alvo:int, posicao:Vector2):
	var peca = pecas[alvo]
	peca.position = posicao*passo +offset
	if posicoes.size() >= alvo+1:
		posicoes[alvo] = posicao
	else:
		posicoes.insert(alvo,posicao)

extends VBoxContainer

@onready var fundo_da_resposta: ColorRect = $"../FundoDaResposta"
@onready var cetinhas: Node2D = $"../FundoDaResposta/cetinhas"

var selecionado:Node
var opcoes:Array
var posicoes: Array[int] = [0,1,2,3]
var offset:int = 0

var opcaoAtual:int = 0:
	#mantem o valor da tela atual entre 0 e 3
	set(valor):
		if valor >= 0:
			opcaoAtual = abs(valor) % 4
		else:
			opcaoAtual = 3
		
		call_deferred("updateFundo")


var proximaOpção:int :
	set(valor):
		if valor >= 0:
			proximaOpção = abs(valor) % 4
		else:
			proximaOpção = 3

func _ready() -> void:
	opcoes = get_children()

func moverPosicao(item, novaPosi):
	posicoes.erase(item)
	posicoes.insert(novaPosi,item)
	get_tree().call_group("perguntasReal","set_resposta",posicoes)

func updateFundo():
	fundo_da_resposta.global_position.y = opcoes[opcaoAtual].global_position.y

func _input(event: InputEvent) -> void:
	if selecionado:
		if event.is_action_pressed("interagir"):
			cetinhas.visible = false
			selecionado = null
		
		if event.is_action_pressed("baixo"):
			proximaOpção = opcaoAtual + 1
			moverPosicao(posicoes[opcaoAtual],proximaOpção)
			move_child(selecionado,proximaOpção)
			opcoes = get_children()
			opcaoAtual += 1
		
		if event.is_action_pressed("cima"):
			proximaOpção = opcaoAtual - 1
			moverPosicao(posicoes[opcaoAtual],proximaOpção)
			move_child(selecionado,proximaOpção)
			opcoes = get_children()
			opcaoAtual -= 1
		
		
		return
	
	if event.is_action_pressed("baixo"):
		opcaoAtual += 1
	
	if event.is_action_pressed("cima"):
		opcaoAtual -= 1
	
	if event.is_action_pressed("interagir"):
		cetinhas.visible = true
		selecionado = opcoes[opcaoAtual]

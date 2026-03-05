extends Node2D
class_name MainScene

# pegando os nodes que vai precisar como variaveis
#
# @onready basicamente cria ums referencia a um node para que vc possa pegar coisas
# ou alterar valores dele
@onready var camera_2d: Camera2D = $Camera2D
@onready var v_box_container: VBoxContainer = $inventario/VBoxContainer
@onready var ultima_cena_gameboy:CenaGameboy = $GameBoyManager/PausaMenu
@onready var game_boy_manager: CanvasLayer = $GameBoyManager
@onready var segura_cartucho: VBoxContainer = $GameBoyManager/seguraCartucho


# pegano todos os lados da sala, os colocando em um array e guardando a lado atual 
@onready var tela_1: Control = $"tela 1"
@onready var tela_2: Control = $"tela 2"
@onready var tela_3: Control = $"tela 3"
@onready var tela_4: Control = $"tela 4"
var telas:Array[Control]
var tela_atual:int = 0:
	#mantem o valor da tela atual entre 0 e 3
	set(valor):
		if valor >= 0:
			tela_atual = abs(valor) % 4
		else:
			tela_atual = 3

# os items que o jogador tem
#
# é definido assim {string:label}, a string é o nome do item, a a label é um texto que aparece
# na tela quando vc pega o item
var items:Dictionary = {}

var foco_atual:Node2D = self


func _ready() -> void:
	telas = [tela_1,tela_2,tela_3,tela_4]
	camera_2d.position = telas[tela_atual].position
	game_boy_manager.hide()

# a função _input(event: InputEvent) roda toda vez que vc toca em uma tecla
# e retorna a tecla como event
func _input(event: InputEvent) -> void:
	# se event for um dos botoes definidos para espaço usa gameboy_trocar()
	# vá no project no canto superior esquerdo -> project settings -> input map pra voce ver 
	# oq tá mapeado em que, e se quiser mapear mais
	
	if event.is_action_pressed("esquerda"):
		tela_atual = tela_atual - 1
		camera_2d.position = telas[tela_atual].position
	
	if event.is_action_pressed("direita"):
		tela_atual = tela_atual + 1
		camera_2d.position = telas[tela_atual].position


func _process(delta: float) -> void:
	# isso funcionaria na função input, mas eu quero que isso sempre esteja ativo
	# ent dexei no process
	if Input.is_action_just_pressed("espaço"):
		if foco_atual is CenaGameboy:
			gameBoy_trocar(self)
		else:
			gameBoy_trocar(ultima_cena_gameboy)
	
	if Input.is_action_just_pressed("baixo") and foco_atual is CenaReal:
		set_cena_ativa(self)

# função pra adicionar um item no dicionario
func adicionar_item(item:String):
	# se items tem o item retorna
	if items.has(item):
		return
	
	# uma label é um node que mostra texto, aqui cria uma nova e coloca o texto para ser
	# o nome do item e dps adciona a label ao vbox
	var nova_label = Label.new()
	nova_label.text = item
	v_box_container.call_deferred("add_child",nova_label)
	
	# adciona no dicionario de items desse jeito {item:nova_label}
	items[item] = nova_label


# função que é usada para ver se o jogador tem um item
func usar_item(item:String,remover:bool) -> bool:
	# ve se tem nos items
	if items.has(item):
		# se for pra remover deleta a label e depois apaga o item do dicionario
		if remover:
			items[item].queue_free()
			items.erase(item)
		
		return true
	
	return false

# troca entre o gameboy e a realidade
func gameBoy_trocar(novoFoco:Node2D):
	# o gameboy tá sempre ativo, tudo que isso faz é trocar a posição da camera para
	# mostrar ou não o gameboy e se ele recebe inputs
	
	if novoFoco is CenaGameboy:
		ultima_cena_gameboy = novoFoco
	
	
	game_boy_manager.hide()
	set_cena_ativa(novoFoco)

func troca_devagar():
	foco_atual = $GameBoyManager/PausaMenu
	ultima_cena_gameboy = $GameBoyManager/PausaMenu

# usada para ativar e desativar a _input de uma cena quando saimos dela
# e ativar a da pra que estamos trocando
func set_cena_ativa(novoFoco:Node2D):
	if foco_atual:
		foco_atual.set_process_input(false)
	
	novoFoco.set_process_input(true)
	
	if foco_atual:
		if foco_atual.has_method("desativarCena"):
			foco_atual.desativarCena()
	
	if novoFoco.has_method("ativarCena"):
		novoFoco.ativarCena()
	
	
	
	foco_atual = novoFoco

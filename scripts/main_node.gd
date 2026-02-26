extends Node2D
class_name MainScene

# pegando os nodes que vai precisar como variaveis
#
# @onready basicamente cria ums referencia a um node para que vc possa pegar coisas
# ou alterar valores dele
@onready var game_boy_manager: Node2D = $GameBoyManager
@onready var game_boy_char: GameBoyChar = $GameBoyManager/GameBoyChar
@onready var camera_2d: Camera2D = $Camera2D
@onready var v_box_container: VBoxContainer = $canvas/VBoxContainer

# os items que o jogador tem
#
# é definido assim {string:label}, a string é o nome do item, a a label é um texto que aparece
# na tela quando vc pega o item
var items:Dictionary = {}

# a função _input(event: InputEvent) roda toda vez que vc toca em uma tecla
# e retorna a tecla como event
func _input(event: InputEvent) -> void:
	# se event for um dos botoes definidos para espaço usa gameboy_trocar()
	# vá no project no canto superior esquerdo -> project settings -> input map pra voce ver 
	# oq tá mapeado em que, e se quiser mapear mais
	if event.is_action_pressed("espaço"):
		gameBoy_trocar()

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
func gameBoy_trocar():
	# o gameboy tá sempre ativo, tudo que isso faz é trocar a posição da camera para
	# mostrar ou não o gameboy
	if camera_2d.position == Vector2.ZERO:
		camera_2d.position = game_boy_manager.position
		return
	
	camera_2d.position = Vector2.ZERO

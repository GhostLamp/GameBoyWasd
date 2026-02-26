class_name Interagivel
extends CanvasItem

# esse codigo permite que um item seja interagivel

# pega se esta ativo, se precisa de um item pra usar e se remove o item quando usa
@export var ativo:bool = false
@export var requerimento:String = ""
@export var removerItem:bool = false

# um Uso é uma classe que eu criei que define oque o item vai fazer
var usos:Array[Uso]

# pega todos os nodes que são filhos desse e são Uso e coloca eles no array  
func _ready() -> void:
	for i in get_children():
		if i is Uso:
			usos.append(i)


func ativar():
	ativo = true

func desativar():
	ativo = false

# quando vai usar um item
func usar():
	if !ativo:
		return
	
	
	if requerimento != "":
		# se o item tiver um requerimento, faz uma gambiarra pra pegar o node principal
		var pricipal:MainScene = get_tree().current_scene
		
		# isso ve se voce tem o item nessesario
		if pricipal.usar_item(requerimento,removerItem):
			
			usar_usos()
		
		return
	usar_usos()


func usar_usos():
	# pega todos Usos no array e usa a função principal
	for i in usos:
		i.uso()

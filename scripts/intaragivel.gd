class_name Interagivel
extends CanvasItem

@export var ativo:bool = false
@export var requerimento:String = ""
@export var removerItem:bool = false

var usos:Array[Uso]

func _ready() -> void:
	for i in get_children():
		if i is Uso:
			usos.append(i)


func usar():
	if !ativo:
		return
		
	if requerimento != "":
		var pricipal:MainScene = get_tree().current_scene
		
		if pricipal.usar_item(requerimento,removerItem):
			
			usar_usos()
		
		return
	usar_usos()


func usar_usos():
	for i in usos:
		i.uso()

func ativar():
	ativo = true

func desativar():
	ativo = false

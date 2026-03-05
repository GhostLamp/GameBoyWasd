class_name CenaGameboy
extends Node2D
@export var player:Node2D
var ativo:bool
@export var cenaCartucho:PackedScene 

@export var cartucho:Button
@export var nome:String

func _ready() -> void:
	var segura_cartucho: VBoxContainer = $"../seguraCartucho"
	
	var novoCartucho:Cartucho = cenaCartucho.instantiate()
	
	segura_cartucho.call_deferred("add_child",novoCartucho)
	
	novoCartucho.jogo = self
	novoCartucho.text = nome
	
	cartucho = novoCartucho
	
	desativarCena()

func ativarCena():
	show()
	get_parent().show()
	ativo = true
	
	if player:
		player.set_process_input(true)

func desativarCena():
	ativo = false
	hide()
	if player:
		player.set_process_input(false)

func deleter_jogo():
	cartucho.visible = false
	visible = false


func _sair_do_jogo() -> void:
	get_tree().change_scene_to_file("res://cenas/tela_de_inicio.tscn")

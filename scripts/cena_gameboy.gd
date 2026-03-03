class_name CenaGameboy
extends Node2D
@export var player:CharacterBody2D
var ativo:bool
@export var cartucho:Button

func _ready() -> void:
	desativarCena()

func ativarCena():
	show()
	ativo = true
	if player:
		player.set_process_input(true)

func desativarCena():
	ativo = false
	hide()
	if player:
		player.set_process_input(false)

func deleter_jogo():
	cartucho.queue_free()
	queue_free()
	

func _sair_do_jogo() -> void:
	get_tree().quit()

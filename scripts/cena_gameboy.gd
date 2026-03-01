class_name CenaGameboy
extends Node2D
@export var player:CharacterBody2D

func _ready() -> void:
	desativarCena()

func ativarCena():
	show()
	if player:
		player.set_process_input(true)

func desativarCena():
	hide()
	if player:
		player.set_process_input(false)

func _sair_do_jogo() -> void:
	get_tree().quit()

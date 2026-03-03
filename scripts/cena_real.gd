class_name CenaReal
extends Node2D
var ativo:bool

func _ready() -> void:
	desativarCena()

func ativarCena():
	show()
	ativo = true


func desativarCena():
	ativo = false
	hide()

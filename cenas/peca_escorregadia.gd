class_name GameBoyPeca
extends CharacterBody2D

@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@export var tamanho_do_passo:int
@export var numero:int
var andando = false
var centro = Vector2(576,352)

func _ready() -> void:
	$Label.text = str(numero)
	var posi = sign(position-centro)
	get_tree().call_group("escorregaReal","set_peca",numero-1,posi)

func usarPeca():
	for i in 4:
		var direcao = Vector2(cos(PI*i/2),sin(PI*i/2))
		if checarMovimento(direcao):
			return

func checarMovimento(vetor:Vector2) -> bool:
	if andando:
		return false
	
	ray_cast_2d_2.look_at(global_position + vetor)
	ray_cast_2d_2.force_raycast_update()
	if ray_cast_2d_2.is_colliding():
		var colidor = ray_cast_2d_2.get_collider()
		if colidor is GameBoyPeca and colidor.checarMovimento(vetor):
			mover(vetor)
			return true
		
		return false
	
	mover(vetor)
	return true


func mover(vetor:Vector2):
	andando = true
	
	var posicaoFinal = position + vetor * tamanho_do_passo
	
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self,"position",posicaoFinal,0.1)
	tween.tween_callback(pararDeMover)
	
	var posi = sign(posicaoFinal-centro)
	get_tree().call_group("escorregaReal","set_peca",numero-1,posi)

func pararDeMover():
	andando = false

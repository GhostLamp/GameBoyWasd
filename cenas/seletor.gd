extends Area2D

@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2

@export var tamanho_do_passo:int

var andando = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interagir"):
		pegarPeca()
	
	if andando:
		return
	
	var direcao:Vector2= Input.get_vector("esquerda", "direita","cima", "baixo")
	direcao = round(direcao)
	
	checarMovimento(direcao)

func pegarPeca():
	for i in get_overlapping_bodies():
		if i is GameBoyPeca:
			i.usarPeca()
			return

func checarMovimento(vetor:Vector2) -> bool:
	ray_cast_2d_2.look_at(global_position + vetor)
	
	ray_cast_2d_2.force_raycast_update()
	if ray_cast_2d_2.is_colliding():
		return false
	
	mover(vetor)
	return true


func mover(vetor:Vector2):
	andando = true
	var posicaoFinal = position + vetor * tamanho_do_passo
	
	var tween:Tween = get_tree().create_tween()
	tween.tween_property(self,"position",posicaoFinal,0.1)
	tween.tween_callback(pararDeMover)

func pararDeMover():
	andando = false

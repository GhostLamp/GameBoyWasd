class_name GameBoyChar
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var olhando_para: Node2D = $OlhandoPara
@onready var ray_cast_2d: RayCast2D = $OlhandoPara/RayCast2D


var step_size:float = 200
var andando:bool = false
var direcao:Vector2 = Vector2.ZERO

func _ready() -> void:
	step_size = collision_shape_2d.shape.get_rect().size.x


func _physics_process(_delta: float) -> void:
	direcao= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direcao.y != 0 and direcao.x != 0:
		direcao.y = 0
		direcao = direcao.normalized()
	olhando_para.look_at(global_position + direcao)
	
	ray_cast_2d.force_raycast_update()
	var colide = ray_cast_2d.is_colliding()
	
	if Input.is_action_just_pressed("ui_accept"):
		interagir()
	
	if direcao and andando == false and colide == false:
		mover()

func interagir():
	var colidor = ray_cast_2d.get_collider()
	if !colidor:
		return
	
	if colidor.has_method("usar"):
		colidor.usar()

func mover():
	andando = true
	
	var posicaoFinal = position + direcao*step_size
	var tween:Tween = get_tree().create_tween()
	
	tween.tween_property(self,"position",posicaoFinal,0.3)
	tween.tween_callback(pararDeMover)

func pararDeMover():
	andando = false

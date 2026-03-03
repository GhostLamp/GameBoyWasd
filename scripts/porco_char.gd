class_name PorcoChar
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var olhando_para: Node2D = $OlhandoPara
@onready var ray_cast_2d: RayCast2D = $OlhandoPara/RayCast2D
@export var label: Label 

const PEDRA = preload("uid://dfr4bd48fgx1w")


var tamanho_do_passo:float
var andando:bool = false
var direcao:float = 0

var pedras:int = 0:
	set(value):
		pedras = value
		label.text = "pedras: " + str(pedras)

# a função ready é a Awake/on_enable da unity
func _ready() -> void:
	# eu botoo tamanho do passo pra ser o tamanho da colisão assim msm se a gente decidir 
	# mudar algum tamanho no editor, não vai precisar mecher em valores no codigo
	tamanho_do_passo = collision_shape_2d.shape.get_rect().size.x
	
	
	set_process_input(false)

# essas funções podem ser usadas no _physics_process 
# mas eu passei elas pro input pra ficar mais facil de ativar e desativar os inputs
func _input(event: InputEvent) -> void:
	# se vc ja usou input.ReadValue<Vector2>() na unity é basicamente a mesma coisa
	# pega o input e coloca num vetor2 onde esquerda e direita é 1 e -1 no x, o mesmo pra
	# cima e baixo no y
	direcao= Input.get_axis("cima", "baixo")
	
	
	# se apertar o botão de interagr
	if Input.is_action_just_pressed("interagir") and !andando:
		interagir()

func _physics_process(_delta: float) -> void:
	if andando == true:
		return
	
	
	# gira o esse node para a olhar na direção que a gente tá indo
	olhando_para.look_at(global_position + Vector2.DOWN*direcao)
	
	# o ray cast permite ver se tem alguma colisão na frente dele, como o raycast é filho
	# do olhando_para, ele tambem vai estar olhando na direção que o jogador quer ir
	ray_cast_2d.force_raycast_update()
	var colide = ray_cast_2d.is_colliding()
	
	# se o raycast não colidir tiver uma direção diferente de (0,0) o jogador pode andar
	if direcao and colide == false:
		mover()

func interagir():
	if  pedras <= 0:
		return
	
	pedras -=1
	var nova_pedra = PEDRA.instantiate()
	nova_pedra.position =  global_position + Vector2(40,0)
	get_parent().call_deferred("add_child",nova_pedra)

func mover():
	andando = true
	
	# calcula a posição final
	var posicaoFinal = position + Vector2.DOWN* direcao*tamanho_do_passo
	
	# tween é um processo que move de um valor a outro suavemente
	var tween:Tween = get_tree().create_tween()
	
	# nesse caso eu to movendo a posição até a posição final em 0.15 segundos
	# quando termina chama a função no callback
	tween.tween_property(self,"position",posicaoFinal,0.15)
	tween.tween_callback(pararDeMover)

func pararDeMover():
	andando = false

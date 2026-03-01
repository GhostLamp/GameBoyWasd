class_name GameBoyChar
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var olhando_para: Node2D = $OlhandoPara
@onready var ray_cast_2d: RayCast2D = $OlhandoPara/RayCast2D


var tamanho_do_passo:float
var andando:bool = false
var direcao:Vector2 = Vector2.ZERO

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
	direcao= Input.get_vector("esquerda", "direita", "cima", "baixo")
	
	
	# se apertar o botão de interagr
	if Input.is_action_just_pressed("interagir"):
		interagir()

func _physics_process(_delta: float) -> void:
	if andando == true:
		return
	
	# isso aqui é pra impedir de andar diagonalmente
	if direcao.y != 0 and direcao.x != 0:
		direcao.y = 0
		direcao = direcao.normalized()
	
	# gira o esse node para a olhar na direção que a gente tá indo
	olhando_para.look_at(global_position + direcao)
	
	# o ray cast permite ver se tem alguma colisão na frente dele, como o raycast é filho
	# do olhando_para, ele tambem vai estar olhando na direção que o jogador quer ir
	ray_cast_2d.force_raycast_update()
	var colide = ray_cast_2d.is_colliding()
	
	# se o raycast não colidir tiver uma direção diferente de (0,0) o jogador pode andar
	if direcao and colide == false:
		mover()

func interagir():
	# pega com quem o raycast tá colidindo
	var colidor = ray_cast_2d.get_collider()
	
	# se o colidor não existir restorna
	if !colidor:
		return
	
	# vê se o colidor é da classe interagivel, se for interage com ele
	if colidor is Interagivel:
		colidor.usar()

func mover():
	andando = true
	
	# calcula a posição final
	var posicaoFinal = position + direcao*tamanho_do_passo
	
	# tween é um processo que move de um valor a outro suavemente
	var tween:Tween = get_tree().create_tween()
	
	# nesse caso eu to movendo a posição até a posição final em 0.15 segundos
	# quando termina chama a função no callback
	tween.tween_property(self,"position",posicaoFinal,0.15)
	tween.tween_callback(pararDeMover)

func pararDeMover():
	andando = false

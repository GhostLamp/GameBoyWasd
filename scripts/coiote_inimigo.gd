class_name CoioteInimigo
extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var tamanho_do_passo:float
var andando:bool = false
var direcao:float = -1

var vida = 1

# a função ready é a Awake/on_enable da unity
func _ready() -> void:
	# eu botoo tamanho do passo pra ser o tamanho da colisão assim msm se a gente decidir 
	# mudar algum tamanho no editor, não vai precisar mecher em valores no codigo
	tamanho_do_passo = collision_shape_2d.shape.get_rect().size.x
	
	
	set_process_input(false)

func _physics_process(_delta: float) -> void:
	var pai:CenaGameboy = get_parent().get_parent()
	
	if !pai.ativo:
		return
	
	if andando == true:
		return
	
	
	mover()


func pedrada():
	vida -= 1
	if vida <= 0:
		queue_free()


func mover():
	andando = true
	
	# calcula a posição final
	var posicaoFinal = position + Vector2.LEFT*tamanho_do_passo
	
	# tween é um processo que move de um valor a outro suavemente
	var tween:Tween = get_tree().create_tween()
	
	# nesse caso eu to movendo a posição até a posição final em 0.15 segundos
	# quando termina chama a função no callback
	tween.tween_property(self,"position",posicaoFinal,1.5)
	tween.tween_callback(pararDeMover)

func pararDeMover():
	andando = false

extends Node2D

# isso basicamente só se apaga no momento que o jogo começa
# se quiser deixar um ""comentario"" na parte do editor é só adicionar uma label
# e colocar como filha disso
func _ready() -> void:
	queue_free()

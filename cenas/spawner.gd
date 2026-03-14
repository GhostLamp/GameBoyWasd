extends Node2D

@export var max_intervalo:float
@export var intervalo:float
@export var spawn:PackedScene

func _physics_process(delta: float) -> void:
	var pai:CenaGameboy = get_parent().get_parent()
	
	if !pai.ativo:
		return
	
	if intervalo > 0:
		intervalo -= delta
		return
	
	intervalo = max_intervalo
	
	var novo_spawn = spawn.instantiate()
	
	novo_spawn.global_position = global_position + Vector2.DOWN * 64 * randi_range(1,5)
	
	get_parent().call_deferred("add_child",novo_spawn)

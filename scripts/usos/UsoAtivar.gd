extends Uso

func uso():
	# se for interagivel, troca entre ele entre estar ativado e desativado
	if target is  Interagivel:
		
		target.ativar()

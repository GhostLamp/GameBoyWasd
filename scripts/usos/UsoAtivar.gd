extends Uso

func uso():
	target.visible = true
	if !target.has_method("usar"):
		return
	
	if target.ativo:
		target.desativar()
		return
	target.ativar()

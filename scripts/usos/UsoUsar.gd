extends Uso

func uso():
	if target.has_method("usar"):
		target.usar()

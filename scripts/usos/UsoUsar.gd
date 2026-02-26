extends Uso

# usa a função usardo alvo se ele for interagivel
func uso():
	if target is Interagivel:
		target.usar()

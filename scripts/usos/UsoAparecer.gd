extends Uso

func uso():
	if get_parent().visible:
		get_parent().visible = false
		return
	get_parent().visible = true

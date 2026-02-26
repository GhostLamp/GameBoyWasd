extends Uso

# faz com que o node que tem isso apareca ou desapareca ao ser usado
func uso():
	if get_parent().visible:
		get_parent().visible = false
		return
	get_parent().visible = true

extends Uso

# faz com que o node que tem isso apareca ou desapareca ao ser usado
func uso():
	if target.visible:
		target.visible = false
		return
	target.visible = true

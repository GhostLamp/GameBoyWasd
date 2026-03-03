extends ColorRect


var colors:Array[Color] = [Color.WHITE,Color.RED,Color.GREEN,Color.BLUE]

var colorVal:int = 0:
	set(valor):
		if valor >= 0:
			colorVal = abs(valor) % 4
		else:
			colorVal = 3 
		
		color = colors[colorVal]


func _on_trocar_cor_cima_button_down() -> void:
	colorVal += 1


func _on_trocar_cor_baixo_button_down() -> void:
	colorVal -= 1

extends Label

var label 

func _ready():
	label = get_text()

func _process(delta):
	set_text(label + str(delta))


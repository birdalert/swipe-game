extends Label

var label 

func _ready():
	label = get_text()

func _process(delta):
	#set_text('FPS: ' + str(Performance.get_monitor(Performance.TIME_FPS)))
	set_text(label + str(Engine.get_frames_per_second()))


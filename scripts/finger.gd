extends Area2D


func _ready():
	monitorable = false

func _process(delta):
	position = get_global_mouse_position()
	
func _input(event):
	if event is InputEventScreenTouch or Input.is_action_pressed('left_mouse_button'):
		monitorable = true
	else:
		monitorable = false

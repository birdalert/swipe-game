extends KinematicBody2D

onready var DebugInfo = get_node('/root/main/DebugInfo')
onready var rv_Line2D = get_node('/root/main/rv_Line2D')

var mousePositions = []
var offset = Vector2(0,0)
var clicked
var dragging
var releaseVector

func _ready():
	$cardParticles.emitting = false

func _physics_process(delta):
	# Create an array of 3 of the last mouse positions
	mousePositions.append(get_global_mouse_position())
	if len(mousePositions) > 3:
		mousePositions.pop_front()
	
	if Input.is_action_just_pressed('left_mouse_button'):
		offset = self.get_position() - get_global_mouse_position()
	
	# moving card under mouse and giving velocity when unclicked
	if clicked:
		$cardParticles.emitting = true
		self.position = (get_global_mouse_position() + offset)
		if not Input.is_action_pressed('left_mouse_button'):
			releaseVector = mousePositions[-1] - mousePositions[-2]
			clicked = false
		if releaseVector == Vector2(0,0):
			$cardParticles.emitting = false
	
	if releaseVector != null:
		self.move_and_collide(releaseVector)

# check for clicks or movement on card
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		clicked = true
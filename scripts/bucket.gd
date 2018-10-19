extends Area2D

func _ready():
	connect('body_entered',self, '_on_body_entered')

func _on_body_entered(body):
	# remove card if it matches the bucket name
	if body.is_in_group(str($Label.text)):
		body.queue_free()
	pass
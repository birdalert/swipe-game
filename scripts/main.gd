extends Node2D

var bucketScene = preload('res://scenes/bucket.tscn')
var cardScene = load('res://scenes/card.tscn')
var screenCoords = {"topLeft":[Vector2(0,0),-45],"bottomLeft":[Vector2(0,1080),225],
					"topRight":[Vector2(1920,0),45],"bottomRight":[Vector2(1920,1080),-225]}
var label = 'Countdown'
var allCards = []
var countNo = 0
var cardTotal = 0
var totalTime = 25

func _ready():
	var rankArray = ['ace','2','3','4','5','6','7','8','9','jack','queen','king']
	var suitArray = ['hearts','clubs','diamonds','spades'] 

	# Generate list of all 48 cards to pull from
	for suit in suitArray:
		for rank in rankArray:
			allCards.append(rank + ":" + suit)

	# Generate 4 buckets, their position, rotation and label
	for coord in screenCoords:
		var bucketNode = bucketScene.instance()
		self.add_child(bucketNode)
		bucketNode.position = Vector2(screenCoords[coord][0])
		bucketNode.rotation_degrees = screenCoords[coord][1]
		bucketNode.get_child(1).text = (suitArray[randi()%suitArray.size()])
		suitArray.erase(bucketNode.get_child(1).text)

func _process(delta):
	$Countdown.set_text(label + ":" + str(int(totalTime)))
	totalTime -= delta
	if totalTime < 0:
		get_tree().set_pause(true)
	var cardTotal = get_tree().get_nodes_in_group('card').size()
	# make a new card when there is none in the scene
	if cardTotal < 1:
		var cardNode = cardScene.instance()
		totalTime += 5
		#$Countdown/countdownTimer.set_wait_time(234)
		generate_card(cardNode)
		self.add_child(cardNode)

func generate_card(cardNode):
	randomize()
	var newCard = allCards[randi()%allCards.size()]
	var rank = newCard.split(':')[0]
	var suit = newCard.split(':')[1]
	cardNode.add_to_group(rank)
	cardNode.add_to_group(suit)
	cardNode.get_child(0).set_texture(load("res://sprites/Playing Cards/"
										+ rank + "_of_" + suit + ".png"))
	allCards.erase(newCard)
	cardNode.position = Vector2(1000,525)
	return cardNode

func _on_restart_pressed():
	totalTime = 25
	get_tree().set_pause(false)
	get_tree().reload_current_scene()

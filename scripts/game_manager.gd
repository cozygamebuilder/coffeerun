extends Node

var current_request : Array = []
var selected_ingredients : Array = []

@onready var request_label = $"../CustomerNode/SpeechPanel/Speech"
@onready var feedback_label = $"../UI/FeedbackLabel"
@onready var drink_visual = $"../UI/Drink"

func _ready():
	load_new_customer()

func load_new_customer():
	current_request = ["Espresso"]
	request_label.text = "I'd like an espresso."
	selected_ingredients.clear()
	feedback_label.text = ""
	drink_visual.visible = false  # Hide the drink image

extends Node2D

@onready var game_manager = $GameManager
@onready var beans_button = $CoffeeStationNode/BeansButton
@onready var brew_button = $CoffeeStationNode/BrewButton
@onready var next_button = $UI/NextCustomerButton
@onready var brew_challenge = $UI/BrewChallenge
@onready var brew_bar := $UI/BrewChallenge/BrewBar

var brewing := false
var speed := 50.0  # fill rate per second
var target_range := Vector2(40, 60)

func _ready():
	beans_button.pressed.connect(_on_beans_pressed)
	brew_button.button_down.connect(_on_brew_button_down)
	brew_button.button_up.connect(_on_brew_button_up)
	next_button.pressed.connect(_on_next_customer_pressed)
	brew_challenge.hide()  # hide initially

func _on_beans_pressed():
	if "Espresso" not in game_manager.selected_ingredients:
		game_manager.selected_ingredients.append("Espresso")

func _on_brew_button_down():
	if "Espresso" not in game_manager.selected_ingredients:
		game_manager.feedback_label.text = "You forgot to add beans!"
		brewing = false
		return  # Stop brewing
	start_brewing()

func _on_brew_button_up():
	if brewing:
		stop_brewing()
	brewing = false

func start_brewing():
	brew_bar.value = 0
	brewing = true
	brew_challenge.show()

func stop_brewing():
	brewing = false
	evaluate_brew(brew_bar.value)

func evaluate_brew(value):
	if value >= target_range.x and value <= target_range.y:
		game_manager.feedback_label.text = "Perfect brew!"
		game_manager.drink_visual.visible = true
	elif abs(value - target_range.x) < 10 or abs(value - target_range.y) < 10:
		game_manager.feedback_label.text = "Almost got it..."
	else:
		game_manager.feedback_label.text = "You screwed the brew!"

	await get_tree().create_timer(2.0).timeout
	brew_challenge.hide()

func _process(delta):
	if brewing:
		brew_bar.value += delta * speed
		brew_bar.value = clamp(brew_bar.value, 0, 100)
		if brew_bar.value >= 100:
			stop_brewing()

func _on_next_customer_pressed():
	game_manager.load_new_customer()

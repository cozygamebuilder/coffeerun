extends Control

# Get references to our UI elements
@onready var play_button = $UILayer/MainContainer/ButtonSection/PlayButton
@onready var how_to_play_button = $UILayer/MainContainer/ButtonSection/HowToPlayButton
@onready var settings_button = $UILayer/MainContainer/ButtonSection/SettingsButton
@onready var quit_button = $UILayer/MainContainer/ButtonSection/QuitButton

@onready var how_to_play_panel = $UILayer/HowToPlayPanel
@onready var close_how_to_button = $UILayer/HowToPlayPanel/HowToPlayContainer/CloseButton

@onready var settings_panel = $UILayer/SettingsPanel
@onready var close_settings_button = $UILayer/SettingsPanel/SettingsContainer/CloseSettingsButton

func _ready():
	# This runs when the scene starts
	print("Main menu loaded!")
	
	# Hide panels initially
	how_to_play_panel.visible = false
	settings_panel.visible = false
	
	# Connect button signals (when buttons are clicked)
	play_button.pressed.connect(_on_play_pressed)
	how_to_play_button.pressed.connect(_on_how_to_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	
	close_how_to_button.pressed.connect(_on_close_how_to_pressed)
	close_settings_button.pressed.connect(_on_close_settings_pressed)

# What happens when buttons are clicked
func _on_play_pressed():
	print("Play button clicked!")
	get_tree().change_scene_to_file("res://scenes/Gameplay.tscn")

func _on_how_to_play_pressed():
	how_to_play_panel.visible = true

func _on_settings_pressed():
	settings_panel.visible = true

func _on_quit_pressed():
	get_tree().quit()

func _on_close_how_to_pressed():
	how_to_play_panel.visible = false

func _on_close_settings_pressed():
	settings_panel.visible = false

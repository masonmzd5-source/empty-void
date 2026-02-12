extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
    # Set up menu options
    var start_button = Button.new()
    start_button.text = "Start Game"
    start_button.connect("pressed", self, "_on_start_game_pressed")

    var settings_button = Button.new()
    settings_button.text = "Settings"
    settings_button.connect("pressed", self, "_on_settings_pressed")

    var quit_button = Button.new()
    quit_button.text = "Quit"
    quit_button.connect("pressed", self, "_on_quit_pressed")

    # Add buttons to the main menu
    add_child(start_button)
    add_child(settings_button)
    add_child(quit_button)

func _on_start_game_pressed():
    print("Start Game pressed")
    # Logic to start the game would go here

func _on_settings_pressed():
    print("Settings pressed")
    # Logic to open settings would go here

func _on_quit_pressed():
    get_tree().quit()  # Closes the game
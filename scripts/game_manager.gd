extends Node

# Singleton for managing the game's state, saves, and level progression.
class_name GameManager

var current_level = 1
var game_state = ""
var saved_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
    load_game()

# Function to load game data
func load_game():
    # Load the saved data from a file or resource
    if FileAccess.file_exists("user://save_data.json"):
        var file = FileAccess.open("user://save_data.json", FileAccess.READ)
        saved_data = JSON.parse(file.get_as_text()).result
        current_level = saved_data.get("level", 1)
        file.close()
    else:
        print("No saved data found.")

# Function to save game data
func save_game():
    saved_data["level"] = current_level
    var file = FileAccess.open("user://save_data.json", FileAccess.WRITE)
    file.store_string(JSON.print(saved_data))
    file.close()
    print("Game saved.")

# Update level and save progression
func update_level(new_level:int):
    current_level = new_level
    save_game()
    print("Level updated to: %d", current_level)
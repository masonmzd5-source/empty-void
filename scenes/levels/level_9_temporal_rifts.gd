extends Node2D

# This script is responsible for managing temporal rifts within the game.

var timeScale: float = 1.0
var riftActive: bool = false

func _ready():
    # Initialize rift mechanics
    # Possibly create UI elements for interacting with rifts
    pass

func activateRift():
    riftActive = true
    get_tree().paused = true  # Pause the game when rift is active

    # Logic for time manipulation, e.g., slow down time
    timeScale = 0.5
    _setTimeScale()

func deactivateRift():
    riftActive = false
    get_tree().paused = false  # Resume the game

    # Restore normal time flow
    timeScale = 1.0
    _setTimeScale()

func _setTimeScale():
    # Apply the time scale to the game
    get_tree().time_scale = timeScale
    
func _process(delta):
    if riftActive:
        # Logic for what happens when rift is active
        pass
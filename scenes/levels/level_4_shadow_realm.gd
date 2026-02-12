extends Node2D

# Darkness mechanics and shadow enemies script for level 4 of the Shadow Realm.

var darkness_level : int = 0
var shadow_enemies : Array = []

func _ready():
    # Initialize darkness mechanics
    set_darkness(5)  # Setting initial darkness level
    spawn_shadow_enemies()  # Spawn enemies at the start

func set_darkness(level: int):
    darkness_level = level
    # Implement visual changes to the scene based on darkness level
    var light = $Light   # Assume a Light node exists
    light.intensity = max(0, 1 - (darkness_level * 0.1))  # Clamp intensity between 0 and 1

func spawn_shadow_enemies():
    for i in range(3):
        var enemy = preload("res://scenes/enemy.tscn").instance()  # Load shadow enemy scene
        shadow_enemies.append(enemy)
        add_child(enemy)
        enemy.position = Vector2(randf() * 800, randf() * 600)  # Random position

func _process(delta: float):
    # Update logic for darkness
    if darkness_level > 0:
        darkness_level -= delta * 0.1  # Decrease darkness over time
        set_darkness(darkness_level)

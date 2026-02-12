extends Node2D

# Enemy AI, pathfinding, and combat behavior script.

# Declare member variables here
var health = 100
var speed = 300
var damage = 10
var target = null
var path = []
var current_path_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    target = get_node("../Player") # Assuming there is a Player node to target
    set_process(true)

# Called every frame; "delta" is the elapsed time since the previous frame.
func _process(delta):
    if target:
        update_path()
        if path:
            follow_path(delta)
            check_attack()

# Update the path to the target using a pathfinding algorithm.
func update_path():
    path = [] # Replace with actual pathfinding logic
    # Example: Use A* algorithm to calculate the path to the target

# Follow the calculated path toward the target.
func follow_path(delta):
    if current_path_index < path.size():
        var direction = (path[current_path_index] - position).normalized()
        position += direction * speed * delta
        if position.distance_to(path[current_path_index]) < 10:
            current_path_index += 1
    else:
        current_path_index = path.size()

# Check if the enemy can attack the target.
func check_attack():
    if position.distance_to(target.position) < 50: # Attack range
        target.take_damage(damage)

# Reduce health when taking damage
func take_damage(amount):
    health -= amount
    if health <= 0:
        queue_free() # Remove from the scene

extends Node2D

# Boss: Void Guardian

var health = 1000
var attack_pattern = 1
var attack_timer = 0

func _ready():
    # Initialize boss settings or state here
    pass

func _process(delta):
    if health <= 0:
        die()
    else:
        execute_attack_pattern(delta)

func execute_attack_pattern(delta):
    attack_timer += delta
    if attack_timer >= 2:
        match attack_pattern:
            1:
                basic_attack()
            2:
                charged_attack()
            3:
                summon_minions()
        attack_timer = 0

func basic_attack():
    print("Void Guardian performs a basic attack!")
    # Implement damage logic here

func charged_attack():
    print("Void Guardian charges up for a powerful attack!")
    # Implement powerful attack logic here

func summon_minions():
    print("Void Guardian summons minions to assist in the battle!")
    # Implement minion spawn logic here

func take_damage(amount):
    health -= amount
    if health <= 0:
        die()

func die():
    print("Void Guardian has been defeated!")
    queue_free()  # Remove the boss from the scene

extends Area

# Constants for lava
const LAVA_DAMAGE = 10
const LAVA_AREA = 200
const HEAT_EFFECT_THRESHOLD = 50

var is_in_lava = false

func _ready():
    set_process_input(true)

func _process(delta):
    if is_in_lava:
        apply_heat_effect()

func apply_heat_effect():
    # Apply damage over time if inside lava
    
    # Example of damage application
    var player = get_parent().get_node("Player")
    if player:
        player.apply_damage(LAVA_DAMAGE * get_process_delta_time())

func _on_body_entered(body):
    if body.is_in_group("players"):
        is_in_lava = true
        body.apply_damage(LAVA_DAMAGE)

func _on_body_exited(body):
    if body.is_in_group("players"):
        is_in_lava = false

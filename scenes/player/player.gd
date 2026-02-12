extends KinematicBody2D

# Player controller script for a 2D action game

# Variables for movement
var speed = 200
var jump_force = -400
var gravity = 800
var velocity = Vector2.ZERO
var is_jumping = false
var can_dash = true
var dash_speed = 600
var dash_duration = 0.2
var dash_elapsed = 0.0

# Combat variables
var attack_combo = ["attack_1", "attack_2", "attack_3"]
var current_attack_index = 0
var is_attacking = false

# Animation variables
onready var animation_player = $AnimationPlayer

func _physics_process(delta):
    # Apply gravity
    if is_jumping:
        velocity.y += gravity * delta

    # Movement Input
    var direction = Vector2.ZERO
    if Input.is_action_pressed("ui_right"): 
        direction.x += 1
    if Input.is_action_pressed("ui_left"): 
        direction.x -= 1
    direction = direction.normalized()

    # Update velocity based on input
    if direction != Vector2.ZERO:
        velocity.x = direction.x * speed

    # Jumping
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force
        is_jumping = true

    # Wall Sliding
    if is_on_wall() and not is_on_floor() and !is_jumping:
        velocity.y = max(velocity.y, 0)
        animation_player.play("wall_slide")

    # Dashing
    if Input.is_action_just_pressed("dash") and can_dash:
        start_dash()

    # Move the player
    velocity = move_and_slide(velocity, Vector2.UP)

    # Reset jumping if on floor
    if is_on_floor():
        can_dash = true
        is_jumping = false
        velocity.y = 0
        animation_player.play("idle")

    # Animation updates
    if is_attacking:
        return
    update_animation(direction)

func update_animation(direction):
    if direction.x != 0:
        animation_player.play("run")
    else:
        animation_player.play("idle")

func start_dash():
    dash_elapsed = 0
    velocity.x = dash_speed * (Input.is_action_pressed("ui_right") ? 1 : -1)
    can_dash = false
    is_jumping = false
    animation_player.play("dash")

func _process(delta):
    if dash_elapsed < dash_duration:
        dash_elapsed += delta
        if dash_elapsed >= dash_duration:
            velocity.x = 0
            is_jumping = false
            animation_player.play("idle")
    else:
        can_dash = true

func attack():
    if not is_attacking:
        is_attacking = true
        animation_player.play(attack_combo[current_attack_index])
        current_attack_index = (current_attack_index + 1) % attack_combo.size()
class_name Player
extends KinematicBody2D

var is_active: bool = false

var max_jump_height: float = 2.25 * Globals.TILE_SIZE
var min_jump_height: float = 1 * Globals.TILE_SIZE
var jump_duration: float = 0.5
# Calculated in _ready()
var gravity: float
var gravity_terminal: float
var max_jump_velocity: float
var min_jump_velocity: float

var speed: float = 3.5 * Globals.TILE_SIZE
var velocity := Vector2.ZERO

var is_jumping: bool = false

onready var jump_buffer: Timer = $JumpBuffer

func _ready() -> void:
	gravity = 2 * max_jump_height / pow(jump_duration,2)
	gravity_terminal = gravity * 5
	max_jump_velocity = - sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = - sqrt(2 * gravity * min_jump_height)


func _physics_process(delta: float) -> void:
	if is_active:
		apply_gravity(delta)
		move()
		jump()
		
	velocity = move_and_slide(velocity,Vector2.UP)


# This is temporary for testing purpuses and will be replaced with pause eventually
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			is_active = true


func apply_gravity(delta) -> void:
	if velocity.y < gravity_terminal:
		velocity.y += gravity * delta
	else: velocity.y = gravity_terminal


func move() -> void:
	velocity.x = speed


func jump():
	if Input.is_action_pressed("ui_accept"):
		is_jumping = true
		jump_buffer.start()
	if is_jumping and is_on_floor():
		velocity.y = max_jump_velocity
	if Input.is_action_just_released("ui_accept"):
		if velocity.y < min_jump_velocity:
			velocity.y = min_jump_velocity


func _on_JumpBuffer_timeout() -> void:
	is_jumping = false

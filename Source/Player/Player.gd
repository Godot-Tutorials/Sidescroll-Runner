class_name Player
extends KinematicBody2D



export var speed: int = 300
export var gravity: int = 10
export var gravity_terminal: int = 1000

var velocity := Vector2.ZERO
var is_active: bool = false

func _physics_process(delta: float) -> void:
	if is_active:
		apply_gravity()
		move()
		jump()
		
	velocity = move_and_slide(velocity,Vector2.UP)
	print(is_on_floor())




# This is temporary for testing purpuses and will be replaced with pause eventually
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			is_active = true


func apply_gravity() -> void:
	if velocity.y < gravity_terminal:
		velocity.y += gravity
	else: velocity.y = gravity_terminal


func move() -> void:
	velocity.x = speed


func jump():
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = -gravity*20

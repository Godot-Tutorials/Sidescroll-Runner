class_name Player
extends KinematicBody2D


signal distance_milestone_achived

var is_active: bool = false

# Jumping
var max_jump_height: float = 2.25 * Globals.TILE_SIZE
var min_jump_height: float = 1 * Globals.TILE_SIZE
var jump_duration: float = 0.5
var is_jumping: bool = false
var jumped: bool = false
var can_coyote_jump: bool = true
var can_multijump: bool = false
var multijump_limit: int = 2 # min 2 to be able to double jump
var multijump_count: int = 0

# Horizontal movement
var speed: float = 3.5 * Globals.TILE_SIZE
var velocity := Vector2.ZERO

# Calculated in _setup_jump_parameters()
var gravity: float
var gravity_terminal: float
var max_jump_velocity: float
var min_jump_velocity: float

# Running distance calculations
var distance_milestone = 500
var distance_milestone_achived = 1

onready var starting_distance: float = position.x
onready var jump_buffer: Timer = $JumpBuffer
onready var coyote_time: Timer = $CoyoteTime
onready var animated_sprite: AnimatedSprite = $AnimatedSprite
onready var my_camera: Camera2D = $Camera2D

func _ready() -> void:
	_setup_signals_connections()
	_setup_jump_parameters()
	_control_animations()


func _physics_process(delta: float) -> void:
	if is_active:
		_apply_gravity(delta)
		_process_jumping()
		_move()
		
	inform_about_passing_distance_milestone()


func _process(delta: float) -> void:
	_control_animations()


# This is temporary for testing purpuses and will be replaced with pause eventually
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			is_active = true


func _setup_signals_connections() -> void:
	self.connect("distance_milestone_achived", PlayerData,"_on_Player_distance_milestone_achived")
	PlayerData.connect("out_of_oxygen",self, "_on_PlayerData_out_of_oxygen")


func _on_JumpBuffer_timeout() -> void:
	is_jumping = false


func _on_CoyoteTime_timeout() -> void:
	can_coyote_jump = false


func _on_PlayerData_out_of_oxygen() -> void:
	# New Camera
	var cam: Camera2D = Camera2D.new()
	cam.zoom = Vector2(2,2)
	cam.global_position = global_position
	var root = get_tree().current_scene
	root.add_child(cam)
	my_camera.current = false
	cam.current = true
	#Die
	queue_free()
 

func _setup_jump_parameters() -> void:
	gravity = 2 * max_jump_height / pow(jump_duration,2)
	gravity_terminal = gravity * 5
	max_jump_velocity = - sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = - sqrt(2 * gravity * min_jump_height)


func _apply_gravity(delta) -> void:
	if velocity.y < gravity_terminal:
		velocity.y += gravity * delta
	else: velocity.y = gravity_terminal


func _move() -> void:
	velocity.x = speed
	velocity = move_and_slide(velocity,Vector2.UP)


func _process_jumping() -> void:
	reset_jumping_capabilities()
	# Regular jump
	if not can_multijump:
	# We can jump even if we press jump slighly befor touching ground thanks to jump_buffer
		if Input.is_action_pressed("jump"):
			is_jumping = true
			jump_buffer.start()
			if is_jumping and can_coyote_jump:
				jumped = true
				velocity.y = max_jump_velocity
				can_coyote_jump = false
	
	#Multijump
	else:
		# If we did more than one jump we can check if we can multijump
		if can_multijump and Input.is_action_pressed("jump"):
			_do_multijump()
			# Reset multijump so we don't fly up continuesly while we hold jump key
			can_multijump = false
	
	# Apply half-jump 
	if Input.is_action_just_released("jump"):
		if velocity.y < min_jump_velocity:
			velocity.y = min_jump_velocity
		
		# Decide if we can multijump
		multijump_count +=1
		if multijump_count > multijump_limit:
			multijump_count = multijump_limit
			can_multijump = false
		else:
			if jumped:
				can_multijump = true


func _do_multijump()-> void:
	if multijump_count < multijump_limit:
		velocity.y = max_jump_velocity
		is_jumping = true
		jump_buffer.start()


func reset_jumping_capabilities() -> void:
	# prevent multijump if falling for too long.
	if velocity.y > gravity:
		can_multijump = false
	#reset everything when touching floor
	_activate_coyote_time()
	if is_on_floor():
		can_coyote_jump = true
		multijump_count = 0
		can_multijump = false
		jumped = false


func _activate_coyote_time() -> void:
#Keeps timer restaring for as long as we touch floor
	if is_on_floor() == true:
		coyote_time.start()


func calculate_distance_run() -> float:
	var distance_run_so_far = position.x - starting_distance
	return distance_run_so_far


func inform_about_passing_distance_milestone() -> void:
	var distance_run_so_far: float = calculate_distance_run()
	if distance_run_so_far > distance_milestone * distance_milestone_achived:
		distance_milestone_achived += 1
		emit_signal("distance_milestone_achived")


func _control_animations() -> void:
	if is_active:
		if velocity.y < 0:
			animated_sprite.play("jump")
		elif velocity.y > 0:
			animated_sprite.play("fall")
		else:
			animated_sprite.play("run")
	else: 
		animated_sprite.play("idle")

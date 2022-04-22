extends KinematicBody2D

export (int) var speed = 200
export (int) var gravity = 1800
export (int) var jump_speed = -300

var velocity = Vector2.ZERO 

func get_input ():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	var dir = Input.get_action_strength("right")  - Input.get_action_strength("left")
	if dir != 0:
		velocity.x = move_toward(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, friction)
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = jump_speed
	if velocity.x == 0: 
		velocity.x = 0
		Player_state = state.Idle
	if  velocity.x != 0:
		Player_state = state.Run


export (float,0,1.0) var friction = 10 
export (float,0,1.0) var acceleration = 25
enum state {Idle, Run}
var Player_state = state.Idle 
func update_animation():
	if velocity.x <0:
		$Sprite.flip_h = true
	if velocity.x >0:
		$Sprite.flip_h -false
	match(Player_state):
		state.Idle:
			$AnimationPlayer.play("Idle")
		state.Run:
			$AnimationPlayer.Play("Run")
	velocity = move_and_slide(velocity, Vector2.UP)
	update_animation()









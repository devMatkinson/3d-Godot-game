extends CharacterBody3D
@onready var springArm = $SpringArm3D
@onready var mesh : MeshInstance3D = $MeshInstance3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player_health = 10.0
var angular_acceleration:= 7

var object_class = preload("res://ball.tscn")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_alive = true


func _physics_process(delta):
	# Add the gravity.
	if !is_alive:
		return
		
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#if Input.is_action_just_pressed("Shoot"):
		#var object_instance = object_class.instantiate()
		#var root = get_tree().get_root().get_node("World")
		#root.add_child(object_instance)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = direction.rotated(Vector3.UP,springArm.rotation.y)
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_area_entered(body):
	$Timer.start()
	$Timer.paused = false
	if body.is_in_group('Emeny_Punch'):
		player_health-= 1
		$ProgressBar.value = player_health * 10
		if player_health <= 0:
			is_alive = false
			Game_Over()
			$AnimationPlayer.play("game over")
		move_and_slide()
	pass # Replace with function body.


func _on_timer_timeout():
	#player_health-= 1
	#$ProgressBar.value = player_health * 10
	#if player_health <= 0:
		#is_alive = false
		#Game_Over()
		#$AnimationPlayer. play("game over")
		#$Timer.paused =true
	pass # Replace with function body.


func _on_area_3d_body_entered(body):
	print(body.get_groups())
	if body.is_in_group('Enemy'):
		
		velocity = body.linear_velocity * 10
		velocity.y = 0
		move_and_slide()
	pass # Replace with function body.


func _on_area_3d_area_exited(area):
	$Timer.paused = true
	pass # Replace with function body.
	
func Game_Over():
	$Panel.visible =  true
	
	

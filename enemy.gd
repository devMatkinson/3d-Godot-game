extends RigidBody3D

const SPEED = 100.0
var player_detected = false
var player = null
var health = 1


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if player_detected:
		var move_direction = (player.global_position - global_position).normalized()
		apply_central_force(move_direction * SPEED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_hitbox_area_entered(body):
	if body.is_in_group("Bullet"):
		health -=1
		if health <= 0:
			queue_free()
	pass # Replace with function body.


func _on_player_detect_area_entered(area):
	if area.is_in_group("Player"):
		player = area
		player_detected = true
	pass # Replace with function body.

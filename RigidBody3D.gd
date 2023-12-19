extends RigidBody3D

@export var initialForce = 50.00

var speed = 10.0
# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_impulse(global_transform.basis.z * initialForce)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position = global_transform.basis.z * speed * delta
	pass 

extends Node3D

var object_class = preload("res://enemy.tscn")
@onready var shoot_position = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var root = get_tree().get_root().get_node("World")
	print("shoot")
	var object_instance = object_class.instantiate()
	object_instance.position = shoot_position.global_position
	root.add_child(object_instance)
	pass # Replace with function body.

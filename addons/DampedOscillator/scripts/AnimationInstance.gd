extends Node


# node values
var node
var propertie
var original_value

# Oscillator values
var damp = 0.0
var spring_force = 0.0

var velocity = 0.0
var displacement = 0.0
var scale_factor = 1.0

var active = true

signal started
signal ended

func _physics_process(delta):
	# Do the math
	var force = -spring_force * displacement - damp * velocity
	velocity += force * delta
	displacement += velocity * delta
	
	# Check if node is gone
	var wr = weakref(node)
	
	if !wr.get_ref():
		set_physics_process(false)
		queue_free()
		return
	
	# Apply the math
	
	match typeof(node.get(propertie)):
		TYPE_FLOAT:
			node.set(propertie, original_value + displacement*scale_factor)
		TYPE_INT:
			node.set(propertie, original_value + int(displacement*scale_factor))
		TYPE_VECTOR2:
			node.set(propertie, original_value + Vector2(displacement,-displacement)*scale_factor )
	
	if abs(velocity - 0) < 0.001:
		end() # Bye bye

func start():
	set_physics_process(true)
	active = true
	emit_signal("started")

func end():
	emit_signal("ended")
	node.set(propertie, original_value)
	queue_free()

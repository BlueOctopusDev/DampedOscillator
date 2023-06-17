extends Node

# Damped oscillator
var animation_instance = preload("res://addons/DampedOscillator/scripts/animation_instance.tscn")
var queue_sysem_enabled = false

func animate(node, propertie: String, string: float, damp: float, velocity: float, scale_factor: float):
	# Spawn new animation instance
	var i = animation_instance.instantiate()
	
	# Update node values
	i.node = node
	i.propertie = propertie
	i.original_value = node.get(propertie)
	
	# Update oscillator values
	i.spring_force = string
	i.damp = damp
	i.velocity = velocity
	i.scale_factor = scale_factor
	
	
	# Queue system
	for animation in get_children():
		if animation.node == node and animation.propertie == propertie:
			if !queue_sysem_enabled:
				i.original_value = animation.original_value
				animation.end()
				add_child(i)
				return
			i.active = false
			
			animation.ended.connect(Callable(i,"start"))
			i.original_value = animation.original_value
			i.set_physics_process(false)
			add_child(i)
			return
	
	# Yayy finally
	add_child(i)


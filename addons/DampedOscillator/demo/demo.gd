extends Control

# Demo video: https://youtu.be/GRZUQI-A0mc

# animate(node, propertie, string, damp, velocity, scale_factor)
# animate(node, string, float, float, float, float)

var spring = 200.0
var damp = 10.0
var velocity = 15.0

@onready var scale_sprite = $SpritesContainer/HBoxContainer/Scale
@onready var rotation_sprite = $SpritesContainer/HBoxContainer/Rotation


func _on_press_me_pressed():
	DampedOscillator.animate(scale_sprite, "scale", spring, damp, velocity, 0.75)
	DampedOscillator.animate(rotation_sprite, "rotation_degrees", spring, damp, velocity, 100.0)


func _ready():
	# Center pivot offset
	scale_sprite.pivot_offset = scale_sprite.size/2
	rotation_sprite.pivot_offset = rotation_sprite.size/2

func _on_spring_value_changed(value):
	spring = value
	update_label()

func _on_damp_value_changed(value):
	damp = value
	update_label()

func _on_velocity_value_changed(value):
	velocity = value
	update_label()

func update_label():
	$Values.text = "spring: "+str(spring) + "\ndamp: " + str(damp) + "\nvelocity: " + str(velocity)




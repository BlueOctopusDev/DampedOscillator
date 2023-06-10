@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("DampedOscillator", "res://addons/DampedOscillator/scripts/damped_oscillator.tscn")

func _exit_tree():
	remove_autoload_singleton("DampedOscillator")

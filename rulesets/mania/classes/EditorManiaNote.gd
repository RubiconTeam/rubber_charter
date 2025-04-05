@tool
extends AnimatedSprite2D
class_name EditorManiaNote

var time:float
var lane:int

# temporary
func _init():
	sprite_frames = load("res://assets/ui/styles/funkin/mania/funkinNotes.tres")
	scale = Vector2(0.3,0.3)
	centered = false

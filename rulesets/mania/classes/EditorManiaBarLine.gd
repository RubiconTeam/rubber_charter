@tool
extends Control
class_name EditorManiaBarLine

var chart:IndividualChart
var note_array:Array[NoteData]

# temporary
@export var note_directions:PackedStringArray

@export var note_size:Vector2 = Vector2(48,48)
@export var note_container:Control
@export var bar_line_label:Label
@export var lanes:int = 4:
	set(value):
		lanes = value
		custom_minimum_size.x = note_size.x * value
		size.x = custom_minimum_size.x

func _load_chart(new_chart:IndividualChart):
	chart = new_chart
	bar_line_label.text = new_chart.Name
	lanes = new_chart.Lanes
	
	# C# arrays in GDScript are strange to say the least
	note_array.clear()
	for note:NoteData in chart.Notes:
		note_array.append(note)
	
	_add_notes_from_chart()

func _add_notes_from_chart():
	for note:NoteData in note_array:
		# temporary
		var new_note:EditorManiaNote = EditorManiaNote.new()
		new_note.animation = note_directions[note.Lane]+"NoteNeutral"
		new_note.position.x = note_size.x * note.Lane
		#
		new_note.time = note.Time
		
		new_note.position.y = note.Time*10
		note_container.add_child(new_note)

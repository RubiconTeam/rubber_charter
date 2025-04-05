@tool
extends Control

@export var bar_line_container:HBoxContainer
@export var bar_line_template:PackedScene

func _setup_bar_lines(charts:Array[IndividualChart]):
	for chart:IndividualChart in charts:
		var bar_line:EditorManiaBarLine = bar_line_template.instantiate()
		bar_line.name = chart.Name
		bar_line._load_chart(chart)
		bar_line_container.add_child(bar_line)
	
	var first_bar_line:EditorManiaBarLine = bar_line_container.get_child(0)
	var separation:int = first_bar_line.note_size.x# * first_bar_line.lanes
	bar_line_container.add_theme_constant_override("separation", separation)

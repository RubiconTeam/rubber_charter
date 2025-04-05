@tool
extends Control
class_name ChartEditor

# Preventing the editor to load the song when opening the scene
var active:bool = !Engine.is_editor_hint()

@export var rulesets:Dictionary[String,PackedScene]
var ruleset_instance:Node
var chart_ruleset:String

@export var meta:SongMeta:
	set(value):
		meta = value
		if active:
			_reload_meta()
		
@export var cur_difficulty_index:int = 0:
	set(value):
		if meta.Difficulties.size() < value and value >= 0:
			cur_difficulty_index = value

func _reload_meta():
	if meta == null:
		printerr("[Rubber] Provided song metadata is null.")
		return
	print("[Rubber] Succesfully loaded metadata for song: "+meta.Name)
	
	_load_difficulty(cur_difficulty_index)

func _load_difficulty(difficulty_idx:int):
	var difficulty:SongDifficulty = meta.Difficulties[difficulty_idx]
	if difficulty == null:
		printerr("[Rubber] Difficulty with index "+str(difficulty_idx)+" not found in song's metadata.")
		return
	
	print("[Rubber] Succesfully loaded "+difficulty.Name+" difficulty with index "+str(difficulty_idx))
	_setup_ruleset()
	
	match ruleset_instance.name.to_lower():
		"mania":
			var charts:Array[IndividualChart]
			for chart:IndividualChart in difficulty.Chart.Charts:
				charts.append(chart)
			ruleset_instance._setup_bar_lines(charts)

func _setup_ruleset() -> void:
	if meta == null:
		printerr("[Rubber] Metadata is null")
		return
	
	chart_ruleset = meta.Difficulties[cur_difficulty_index].RuleSet
	if meta.Difficulties[cur_difficulty_index].RuleSet == null or chart_ruleset.is_empty() or !chart_ruleset in rulesets.keys():
		if chart_ruleset == meta.DefaultRuleset:
			printerr("[Rubber] No editor found for the default ruleset. Returning")
			return
		else:
			chart_ruleset = meta.DefaultRuleset
			printerr("[Rubber] No editor found for the difficulty's ruleset. Falling back to "+chart_ruleset)
			_setup_ruleset()
	
	ruleset_instance = rulesets[meta.DefaultRuleset].instantiate()
	ruleset_instance.name = chart_ruleset
	add_child(ruleset_instance)

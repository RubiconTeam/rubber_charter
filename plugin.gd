@tool
extends EditorPlugin

var addon_path:String = get_script().get_path().get_base_dir()+"/"
var editor_path:String = addon_path+"Editor.tscn"
var editor_instance:ChartEditor

func _enter_tree() -> void:
	if !Engine.is_editor_hint():
		return
	
	editor_instance = ResourceLoader.load(editor_path).instantiate()
	editor_instance.visible = false
	editor_instance.active = true
	EditorInterface.get_editor_main_screen().add_child(editor_instance)
	connect("main_screen_changed", _main_screen_changed)

func _exit_tree() -> void:
	editor_instance.queue_free()
	queue_free()

func _main_screen_changed(screen_name:String):
	editor_instance.visible = screen_name == _get_plugin_name()

func _has_main_screen() -> bool:
	return true

func _get_plugin_icon() -> Texture2D:
	return null

func _get_plugin_name() -> String:
	return "Rubber"

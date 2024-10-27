@tool
class_name PluginCreateSettingConfigManagerWindow extends Window


@onready var line_edit_setting_config_manager: LineEdit = $Panel/VBoxContainer/MarginContainer2/VBoxContainer/HBoxContainer/LineEditSettingConfigManager
@onready var line_edit_setting_data: LineEdit = $Panel/VBoxContainer/MarginContainer3/VBoxContainer2/HBoxContainer/LineEditSettingData
@onready var button_ok: Button = $Panel/VBoxContainer/MarginContainer5/HBoxContainer/ButtonOK

var editor_file_dialog_setting_config_manager : EditorFileDialog
var editor_file_dialog_choose_setting_data : EditorFileDialog

var setting_config_manager_path : String
var setting_data_path : String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	editor_file_dialog_setting_config_manager = EditorFileDialog.new()
	editor_file_dialog_setting_config_manager.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	editor_file_dialog_setting_config_manager.disable_overwrite_warning = true
	editor_file_dialog_setting_config_manager.title = "Set Setting Config Manager Path"
	editor_file_dialog_setting_config_manager.filters = PackedStringArray(["*.gd"]) 
	editor_file_dialog_setting_config_manager.confirmed.connect(set_setting_config_manager_path)
	self.add_child(editor_file_dialog_setting_config_manager)
	
	editor_file_dialog_choose_setting_data = EditorFileDialog.new()
	editor_file_dialog_choose_setting_data.get_line_edit().editable = false
	editor_file_dialog_choose_setting_data.file_mode = EditorFileDialog.FILE_MODE_SAVE_FILE
	editor_file_dialog_choose_setting_data.disable_overwrite_warning = true
	editor_file_dialog_choose_setting_data.title = "Choose Setting Data Path"
	editor_file_dialog_choose_setting_data.filters = PackedStringArray(["*.gd"]) 
	editor_file_dialog_choose_setting_data.confirmed.connect(set_setting_data_path)
	self.add_child(editor_file_dialog_choose_setting_data)
	pass # Replace with function body.


func set_setting_config_manager_path() -> void:
	editor_file_dialog_setting_config_manager.get_line_edit().text = PluginCFSConfigHelper.SETTING_CONFIG_MANAGER_SCRIPT_NAME
	line_edit_setting_config_manager.text = editor_file_dialog_setting_config_manager.current_path
	pass


func set_setting_data_path() -> void:
	line_edit_setting_data.text = editor_file_dialog_choose_setting_data.current_path
	pass


func _on_close_requested() -> void:
	self.hide()
	pass # Replace with function body.


func _on_button_set_setting_config_manager_path_pressed() -> void:
	editor_file_dialog_setting_config_manager.get_line_edit().text = PluginCFSConfigHelper.SETTING_CONFIG_MANAGER_SCRIPT_NAME
	editor_file_dialog_setting_config_manager.popup_file_dialog()
	pass # Replace with function body.


func _on_button_choose_setting_data_path_pressed() -> void:
	editor_file_dialog_choose_setting_data.popup_file_dialog()
	pass # Replace with function body.


func _on_button_ok_pressed() -> void:
	setting_config_manager_path = line_edit_setting_config_manager.text
	setting_data_path = line_edit_setting_data.text
	self.hide()
	pass # Replace with function body.


func _on_button_cancel_pressed() -> void:
	self.hide()
	pass # Replace with function body.

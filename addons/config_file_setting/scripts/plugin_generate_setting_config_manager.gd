@tool
class_name PluginGenerateSettingConfigManager extends Node


var plugin_create_setting_config_manager_window : PluginCreateSettingConfigManagerWindow 


func _enter_tree() -> void:
	plugin_create_setting_config_manager_window = load("res://addons/config_file_setting/scenes/plugin_create_setting_config_manager_window/plugin_create_setting_config_manager_window.tscn").instantiate()
	self.add_child(plugin_create_setting_config_manager_window)
	plugin_create_setting_config_manager_window.visible = false
	pass


func _ready() -> void:
	plugin_create_setting_config_manager_window.button_ok.pressed.connect(generate_setting_config_manager_script)
	pass


func show_plugin_create_setting_config_manager_window() -> void:
	plugin_create_setting_config_manager_window.popup_centered()
	pass


func generate_setting_config_manager_script() -> void:
	if plugin_create_setting_config_manager_window.setting_config_manager_path.is_empty():
		printerr(PluginCFSConfigHelper.ERROR_MESSAGE_PREFIX, "setting config manager path is empty")
		return
	
	if plugin_create_setting_config_manager_window.setting_data_path.is_empty():
		printerr(PluginCFSConfigHelper.ERROR_MESSAGE_PREFIX, "setting data path is empty")
		return
	
	if not FileAccess.file_exists(plugin_create_setting_config_manager_window.setting_data_path):
		printerr(PluginCFSConfigHelper.ERROR_MESSAGE_PREFIX, "file does not exist fot setting data path.", " ", plugin_create_setting_config_manager_window.setting_data_path)
		return
	
	var array_setting_data : Array[String]
	var file_setting_data : FileAccess = FileAccess.open(plugin_create_setting_config_manager_window.setting_data_path, FileAccess.READ)
	while file_setting_data.get_position() < file_setting_data.get_length():
		array_setting_data.append(file_setting_data.get_line())
	file_setting_data.close()
	
	var file_setting_config_manager : FileAccess = FileAccess.open(plugin_create_setting_config_manager_window.setting_config_manager_path, FileAccess.WRITE)
	
	var setting_data_class_name : String
	for data_line : String in array_setting_data:
		if data_line.contains("class_name "):
			setting_data_class_name = get_class_name(data_line)
			break
	
	if setting_data_class_name.is_empty():
		printerr(PluginCFSConfigHelper.ERROR_MESSAGE_PREFIX, "setting data class name get error")
		return
	
	file_setting_config_manager.store_line(PluginCFSConfigHelper.FILE_DATA_BEGIN.format({"class_name":setting_data_class_name}))
	
	file_setting_config_manager.store_line("")
	var function_line_load : String
	for data_line : String in array_setting_data:
		if not data_line.contains("var "):
			continue
		data_line = data_line.replace("var ", "")
		var variable_name : String = data_line.substr(0, data_line.find(":")).replace(" ","")
		var type_index_end : int = data_line.find("=") - data_line.find(":") - 1 if data_line.contains("=") else -1
		var variable_type : String = data_line.substr(data_line.find(":") + 1, type_index_end).replace(" ","")
		function_line_load += "if setting_file.has_section_key(\"setting\", \"{var_name}\"):\n\t".format({"var_name":variable_name})
		function_line_load += "\tsetting_data.{var_name} = {var_type}(setting_file.get_value(\"setting\", \"{var_name}\"))\n\t".format({"var_name":variable_name, "var_type":variable_type})
	file_setting_config_manager.store_line(PluginCFSConfigHelper.FUNCTION_LOAD_SETTING_CONFIG.format({"function_line":function_line_load}))
	
	file_setting_config_manager.store_line("")
	var function_line_save : String
	for data_line : String in array_setting_data:
		if not data_line.contains("var "):
			continue
		data_line = data_line.replace("var ", "")
		var variable_name : String = data_line.substr(0, data_line.find(":")).replace(" ","")
		function_line_save += "setting_file.set_value(\"setting\", \"{var_name}\", setting_data.{var_name})\n\t".format({"var_name":variable_name})
	file_setting_config_manager.store_line(PluginCFSConfigHelper.FUNCTION_SAVE_SETTING_CONFIG.format({"function_line":function_line_save}))
	
	file_setting_config_manager.close()
	
	EditorInterface.get_resource_filesystem().scan()
	
	var editor_plugin : EditorPlugin = EditorPlugin.new()
	editor_plugin.add_autoload_singleton(PluginCFSConfigHelper.AUTOLOAD_NODE_NAME, plugin_create_setting_config_manager_window.setting_config_manager_path)
	pass


func get_class_name(data: String) -> String:
	data = data.replace("class_name ", "")
	data = data.substr(0, data.find(" extends"))
	return data

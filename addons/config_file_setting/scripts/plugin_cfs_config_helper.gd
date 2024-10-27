@tool
class_name PluginCFSConfigHelper


const SETTING_CONFIG_MANAGER_SCRIPT_NAME : String = "setting_config_manager.gd"

const AUTOLOAD_NODE_NAME : String = "SettingConfigManager"


const ERROR_MESSAGE_PREFIX : String = "ConfigFileSetting:"


const FILE_DATA_BEGIN : String = "extends Node

const setting_file_path : String = \"user://setting.ini\"

var setting_data : {class_name} = {class_name}.new()


func _enter_tree() -> void:
	load_setting_config_data()
	pass


func _exit_tree() -> void:
	save_setting_config_data()
	pass
"


const FUNCTION_LOAD_SETTING_CONFIG : String = "# 加载设置配置信息
func load_setting_config_data() -> void:
	var setting_file : ConfigFile = ConfigFile.new()
	var err : Error = setting_file.load(setting_file_path)
	if err != OK:
		return
	
	{function_line}
	pass
"


const FUNCTION_SAVE_SETTING_CONFIG : String = "# 保存设置配置信息
func save_setting_config_data() -> void:
	var setting_file : ConfigFile = ConfigFile.new()
	
	{function_line}
	setting_file.save(setting_file_path)
	pass
"

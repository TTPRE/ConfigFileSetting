extends Node

const setting_file_path : String = "user://setting.ini"

var setting_data : SettingData = SettingData.new()


func _enter_tree() -> void:
	load_setting_config_data()
	pass


func _exit_tree() -> void:
	save_setting_config_data()
	pass


# 加载设置配置信息
func load_setting_config_data() -> void:
	var setting_file : ConfigFile = ConfigFile.new()
	var err : Error = setting_file.load(setting_file_path)
	if err != OK:
		return
	
	if setting_file.has_section_key("setting", "bgm_volume"):
		setting_data.bgm_volume = float(setting_file.get_value("setting", "bgm_volume"))
	if setting_file.has_section_key("setting", "sound_effect_volume"):
		setting_data.sound_effect_volume = float(setting_file.get_value("setting", "sound_effect_volume"))
	if setting_file.has_section_key("setting", "is_window"):
		setting_data.is_window = bool(setting_file.get_value("setting", "is_window"))
	if setting_file.has_section_key("setting", "window_size"):
		setting_data.window_size = Vector2(setting_file.get_value("setting", "window_size"))
	
	pass


# 保存设置配置信息
func save_setting_config_data() -> void:
	var setting_file : ConfigFile = ConfigFile.new()
	
	setting_file.set_value("setting", "bgm_volume", setting_data.bgm_volume)
	setting_file.set_value("setting", "sound_effect_volume", setting_data.sound_effect_volume)
	setting_file.set_value("setting", "is_window", setting_data.is_window)
	setting_file.set_value("setting", "window_size", setting_data.window_size)
	
	setting_file.save(setting_file_path)
	pass

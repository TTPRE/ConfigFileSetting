extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SettingConfigManager.setting_data.bgm_volume)
	print(SettingConfigManager.setting_data.sound_effect_volume)
	print(SettingConfigManager.setting_data.is_window)
	print(SettingConfigManager.setting_data.window_size)
	
	SettingConfigManager.setting_data.bgm_volume = 1
	SettingConfigManager.setting_data.sound_effect_volume = 1
	SettingConfigManager.setting_data.is_window = false
	SettingConfigManager.setting_data.window_size = Vector2.ZERO
	
	print(SettingConfigManager.setting_data.bgm_volume)
	print(SettingConfigManager.setting_data.sound_effect_volume)
	print(SettingConfigManager.setting_data.is_window)
	print(SettingConfigManager.setting_data.window_size)
	pass # Replace with function body.

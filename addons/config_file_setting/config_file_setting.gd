##----------------------------------------------------##
##   #######     #######      #######      #######    ##
##  ##     ##  ##       ##  ##       ##  ##       ##  ##
##         ##  ##       ##  ##       ##  ##       ##  ##
##   #######   ##       ##  ##       ##  ##       ##  ##
##  ##         ##       ##  ##       ##  ##       ##  ##
##  ##         ##       ##  ##       ##  ##       ##  ##
##  #########    #######      #######      #######    ##
##----------------------------------------------------##
## @Description: 根据游戏设置数据脚本类生成设置管理脚本并设置autoload
##
## 项目 -> 工具 -> Config File Setting
## 设置全局自动加载脚本setting_config_manager.gd路径
## 选择游戏设置数据脚本类
## 确认会生成脚本并设置为自动加载
## 
## 使用方式请查看example文件夹下示例
##----------------------------------------------------##
## @Auther: 2000
## @Date: 2024-10-25
## @LastEditTime: 2024-11-09
## @Tags: Setting, 配置, 设置
## @Version: 1.0.0
## @License: MIT license
## @ContactInformation:
##----------------------------------------------------##
@tool
extends EditorPlugin


var plugin_generate_setting_config_manager : PluginGenerateSettingConfigManager


func _enter_tree() -> void:
	initialize()
	add_tool_menu()
	print("Enable ConfigFileSetting")
	pass


func _exit_tree() -> void:
	remove_tool_menu()
	destroy()
	print("Disable ConfigFileSetting")
	pass


func initialize() -> void:
	plugin_generate_setting_config_manager = PluginGenerateSettingConfigManager.new()
	self.add_child(plugin_generate_setting_config_manager)
	pass


func destroy() -> void:
	plugin_generate_setting_config_manager.free()
	pass


func add_tool_menu() -> void:
	add_tool_menu_item("Config File Setting", plugin_generate_setting_config_manager.show_plugin_create_setting_config_manager_window)
	pass


func remove_tool_menu() -> void:
	remove_tool_menu_item("Config File Setting")
	pass

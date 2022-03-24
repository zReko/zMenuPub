function zMenuClass:getMenuLayout()
    return {
        tab_list = {
            {type = "button",menu_id = "weapon_stats_tab",text = "Weapon Stats"},
            {type = "button",menu_id = "aimbot_settings_tab",text = "Aimbot Settings"},
            {type = "button",menu_id = "local_player_tab",text = "Player Setting"},
            {type = "divider"},
            {type = "button",menu_id = "visual_tab",text = "Visuals"},
            {type = "button",menu_id = "enemy_spawner",text = "Spawners"},
            {type = "button",menu_id = "test_tabyes",text = "Test Tab"},
            {type = "button",menu_id = "mission_scripts",text = "Mission Scripts"},
            {type = "button",menu_id = "enemy_opti",text = "Miscellaneous"},
            {type = "button",menu_id = "player_menu",text = "Player Menu"},
            {type = "divider"},
            {type = "button",menu_id = "main_menu_tab",text = "Menu Features"},
            {type = "button",menu_id = "voicelines_tab",text = "Voice Lines"},
            {type = "divider"},
            {type = "button",menu_id = "MENU_STUFF_tab",text = "Menu Settings"},
            {type = "button",menu_id = "keybind_tab",text = "Keybinds"},
            {type = "button",menu_id = "config_tab",text = "Config"},
        },
        main_features = {
            ["main_menu_tab"] = {
                {

                },
                {
                    
                }
            },
            ["player_menu"] = {
            },
            ["mission_scripts"] = {
            },
            ["test_tabyes"] = {
            },
            ["enemy_opti"] = {
            },
            ["weapon_stats_tab"] = {
            },
            ["aimbot_settings_tab"] = {
            },
            ["local_player_tab"] = {
            },
            ["enemy_spawner"] = {
            },
            ["MENU_STUFF_tab"] = {
            },
            ["voicelines_tab"] = {
            },
            ["visual_tab"] = {
            },
            ["keybind_tab"] = {
            },
            ["config_tab"] = {
            }
        }
    }
end

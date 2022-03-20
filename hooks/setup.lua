local orig_init_manager = Setup.init_managers
local orig_quit = Setup.quit
local orig_restart = Setup.restart
local orig_load_start_menu_lobby = Setup.load_start_menu_lobby
local orig_load_start_menu = Setup.load_start_menu

function Setup:init_managers(...)
    DB:create_entry(Idstring("texture"), Idstring("guis/textures/background_pattern"), zMenuTools:modPath() .. "assets/background_pattern.texture")
    DB:create_entry(Idstring("texture"), Idstring("guis/textures/menu_icons"), zMenuTools:modPath() .. "assets/menu_icons.texture")
    orig_init_manager(self, ...)
end
function Setup:quit()
    zMenuUpdator:remove_all()
    orig_quit(self)
end
function Setup:restart()
    zMenuUpdator:remove_all()
    orig_restart(self)
end
function Setup:load_start_menu_lobby()
    zMenuUpdator:remove_all()
    orig_load_start_menu_lobby(self)
end
function Setup:load_start_menu()
    zMenuUpdator:remove_all()
    orig_load_start_menu(self)
end
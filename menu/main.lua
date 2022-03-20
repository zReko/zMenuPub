local zMenuClass = class()

function zMenuClass:init(x,y,w,h,res_x,res_y)
    self.wsMain = zRekoSDK:createCustomResWorkspace(res_x,res_y)
    self.wsMain:connect_keyboard(Input:keyboard())
    self.wsMain:connect_mouse(Input:mouse())
	self.menu_mouse_id = managers.mouse_pointer:get_id()
    self.menu_enabled = false
    self.scroll_data = {}
    self.height_data = {}
    self.icons = {
        toggle_circle = hollow_icons and {3, 2, 27, 26} or {70, 2, 27, 26} ,
        toggle_slider = hollow_icons and {5, 28, 65, 26} or {72, 28, 65, 26} ,
        toggle_circle_hollow = {70, 2, 27, 26},
        config_move = {0, 55, 48, 48},
        background_transparent = {0, 197, 34, 212},
        cross = {51,57,28,28},
        arrow_right = {84,57,28,28},
        arrow_down = {111,56,28,28},
        info = {182,3,64,64},
        check = {253,3,64,64},
        alert = {332,3,64,64}
    }
    self.mainPanel = self.wsMain:panel():panel({layer = 250000})
    self.menu_master_panel = self.mainPanel:panel({layer = 1, alpha = 1,w = w,h = h,x = x, y = y, visible = false})
end
function zMenuClass:reload()
end
function zMenuClass:destory()
end
--local resMAIN = {1600,900}
local resolution = {1920,1080}
--local resMAIN = {2560,1440}
--local resMAIN = {3840,2160}
local padding = 300
local x = padding
local y = padding
local w = resMAIN[1] - padding*2
local h = resMAIN[2] - padding*2
zMenu = zMenuClass:new(x,y,w,h,resolution[1],resolution[2])

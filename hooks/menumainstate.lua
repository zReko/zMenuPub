local orig_at_enter = MenuMainState.at_enter
--enter main menu
function MenuMainState:at_enter(...)
    zMenuTools:initMenu()
    orig_at_enter(self,...)
end

local origi_at_enter = MenuMainState.at_enter
function MenuMainState:at_enter(...)
    zMenuTools:initMenu()
    origi_at_enter(self,...)
end

local orig_at_enter = IngameWaitingForPlayersState.at_enter
local orig_at_exit = IngameWaitingForPlayersState.at_exit
--enter preplanning
function IngameWaitingForPlayersState:at_enter()
    orig_at_enter(self)
    zMenuTools:initMenu()
end
--enter heist
function IngameWaitingForPlayersState:at_exit(...)
    orig_at_exit(self,...)
end

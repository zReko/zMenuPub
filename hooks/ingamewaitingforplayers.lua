local orig_at_exit = IngameWaitingForPlayersState.at_exit
local orig_at_enter = IngameWaitingForPlayersState.at_enter
--enter preplanning
function IngameWaitingForPlayersState:at_enter()
    orig_at_enter(self)
end
--enter heist
function IngameWaitingForPlayersState:at_exit(...)
	orig_at_exit(self,...)
end
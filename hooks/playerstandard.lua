local orig_attack = PlayerStandard._check_action_primary_attack
local orig_steelsight = PlayerStandard._check_action_steelsight
function PlayerStandard:_check_action_primary_attack(...)
    if zMenu:isMenuopen() then
        return
    end
    orig_attack(self,...)
end
function PlayerStandard:_check_action_steelsight(...)
    if zMenu:isMenuopen() then
        return
    end
    orig_steelsight(self,...)
end
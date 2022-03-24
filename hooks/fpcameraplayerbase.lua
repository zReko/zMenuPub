local orig_update_rot = FPCameraPlayerBase._update_rot
function FPCameraPlayerBase:_update_rot(...)
    if zMenuTools:localPlayer() then
        if zMenu:isMenuopen() then
            return
        end
        orig_update_rot(self,...)
        return
    end
    orig_update_rot(self,...)
end
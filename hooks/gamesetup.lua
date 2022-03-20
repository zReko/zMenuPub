local orig_load_packaged = GameSetup.load_packages
local packages = {
    "packages/sm_wish", --ZEAL UNITS
    --ENVIRONMENTS
    "levels/instances/unique/hox_fbi_armory/world", --SUNSET
    "levels/instances/unique/hlm_reader/world", --SUNRISE
    "levels/instances/unique/hlm_vault/world", --FOGGY NIGHT
    "levels/instances/unique/hlm_door_wooden_white_green/world", --NIGHT
    --VOICE LINES
    "levels/narratives/vlad/ukrainian_job/world_sounds",
    "levels/narratives/vlad/jewelry_store/world_sounds",
    "levels/narratives/h_firestarter/stage_3/world_sounds",
    "levels/narratives/elephant/mad/world_sounds",
    --WEATHER
    --"packages/narr_glace", --RAIN
    --VEHICLES
    --"levels/narratives/bain/cage/world/world",
    --"levels/narratives/vlad/shout/world/world",
    --"levels/narratives/vlad/jolly/world/world",
    --"levels/narratives/pbr/jerry/world/world",
    --"levels/instances/unique/born/born_truck/world/world",
    --"levels/narratives/elephant/born/world/world",
}
function GameSetup:load_packages()
    orig_load_packaged(self)
    for i, v in pairs(packages) do
        zMenuTools:loadPackage(v)
    end
end
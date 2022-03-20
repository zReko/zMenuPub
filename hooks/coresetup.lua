local orig___render = CoreSetup.__render
function CoreSetup:__render(...)
    zRekoUpdator:update()
    orig___render(self,...)
end
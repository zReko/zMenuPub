local orig___render = CoreSetup.__render
function CoreSetup:__render(...)
    zMenuUpdator:update()
    orig___render(self,...)
end
local zMenuUpdatorClass = class()
function zMenuUpdatorClass:init()
    self.list_of_funcs = {}
    self.time = 0
end
function zMenuUpdatorClass:update()
    local current_time = zRekoSDK:currentTime()
    for i, v in pairs(self.list_of_funcs) do
        if v[2] > 0 then
            if v[3] <= current_time then
                self.list_of_funcs[i][3] = current_time + (v[2] or 0)
                v[1]()
            end
        else
            v[1]()
        end
    end
end
function zMenuUpdatorClass:update_by_id(id)
    local current_time = zRekoSDK:currentTime()
    local item = self.list_of_funcs[id]
    if item then
        self.list_of_funcs[id][3] = current_time + item[2]
        item[1]()
    end
end
function zMenuUpdatorClass:add(func,id,interval)
    if self.list_of_funcs[id] then
        return
    end
    local current_time = zRekoSDK:currentTime()
    self.list_of_funcs[id] = {func,interval or 0,current_time}
end
function zMenuUpdatorClass:set_speed(id,speed)
    if self.list_of_funcs[id] then
        self.list_of_funcs[id][2] = speed
    end
end
function zMenuUpdatorClass:set_func(id,func)
    if self.list_of_funcs[id] then
        self.list_of_funcs[id][1] = func
    end
end
function zMenuUpdatorClass:has_id(id)
    return self.list_of_funcs[id] and true or false
end
function zMenuUpdatorClass:remove(id,call_before_removing)
    if call_before_removing then
        self.list_of_funcs[id][1]()
    end
    self.list_of_funcs[id] = nil
end
function zMenuUpdatorClass:remove_all(call_before_removing,except)
    local temp = {}
    if except and #except > 0 then
        for i,v in pairs(except) do
            temp[v] = true
        end
    end
    for i,v in pairs(self.list_of_funcs) do
        if call_before_removing then
            self.list_of_funcs[i][1]()
        end
        if except and temp[i] then
            log("UpadatorClass:remove_all(...) ignoring " .. i)
        else
            self.list_of_funcs[i] = nil
        end
    end
end
function zMenuUpdatorClass:func_count()
    local count = 0
    for i,v in pairs(self.list_of_funcs) do
        count = count + 1
    end
    return count
end
zMenuUpdator = zMenuUpdatorClass:new()
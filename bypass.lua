local ugby
local pby

function bypassacs()
    local statetype = Enum.HumanoidStateType
    local rnd = Random.new():NextInteger(150, 100000)
    local mt = getrawmetatable(statetype)
    local mt_index = mt.__index
    setreadonly(mt, false)
    
    mt.__index = newcclosure(function(t, k)
       if not checkcaller() and t == statetype and k == 'StrafingNoPhysics' then
           return rnd
       end
    
       return mt_index(t, k)
    end)
    
    setreadonly(mt, true)
    local Rm, Index, NIndex, NCall, Caller = getrawmetatable(game), getrawmetatable(game).__index, getrawmetatable(game).__newindex, getrawmetatable(game).__namecall, checkcaller or is_protosmasher_caller
    setreadonly(Rm, false)
    Rm.__newindex = newcclosure(function(self, Meme, Value)
        if Caller() then return NIndex(self, Meme, Value) end 
        if tostring(self) == 'HumanoidRootPart' or tostring(self) == 'Torso' then 
            if Meme == 'CFrame' and self:IsDescendantOf(game:GetService('Players').LocalPlayer.Character) then 
                return true -- Credits to ze_lI for this
            end
        end
        return NIndex(self, Meme, Value)
    end)
    setreadonly(Rm, true)
    
    local getrawmetatable = getrawmetatable or debug.getmetatable
    local setrawmetatable = setrawmetatable or debug.setmetatable
    
    local Meta = getrawmetatable(game)
    local Me = game:GetService('Players').LocalPlayer
    local New = {}
    for Name, Method in next, Meta do
    New[Name] = Method
    end
    local FakeHumanoid = Instance.new('Humanoid')
    New.__index = newcclosure(function(self, index)
    if index == 'WalkSpeed' then
    return owsp
    elseif index == 'Changed' then
    return Meta.__index(FakeHumanoid, 'Changed')
    else
    return Meta.__index(self, index)
    end
    end)
    New.__namecall = newcclosure(function(self, ...)
    local Args = {...}
    local Method = Args[#Args]
    if Method == 'GetPropertyChangedSignal' then
    return Meta.__namecall(FakeHumanoid, ...)
    else
    return Meta.__namecall(self, ...)
    end
    end)
    
    local HookChar = function(Char)
    if Char then
    setrawmetatable(Char:WaitForChild('Humanoid'), New)
    end
    end
    HookChar(game:GetService('Players').LocalPlayer.Character)
    local Hook;
    Hook = hookfunction(getrenv().require, newcclosure(function(...)
        local Args = {...}
    
        if not checkcaller() then
            if (getcallingscript().Name == 'HDAdminStarterPlayer' and Args[1].Name == 'MainFramework') then
                return wait(10e1)
            end
        end
    
        return Hook(unpack(Args))
    end))
    local GetFullName = game.GetFullName
    local Hook;
    Hook = hookfunction(getrenv().require, newcclosure(function(...)
        local Args = {...}
    
        if not checkcaller() then
            if (GetFullName(getcallingscript()) == '.ClientMover' and Args[1].Name == 'Client') then
                return wait(10e1)
            end
        end
    
        return Hook(unpack(Args))
    end))
--[[    local LocalPlayer = game:GetService('Players').LocalPlayer.Character.Humanoid
    local OldIndex = nil
    
    OldIndex = hookmetamethod(game, '__index', function(...)
        local Self, Key = ...
    
        if not checkcaller() and Self == LocalPlayer and Key == 'JumpPower' or Key == 'HipHeight' or Key == 'Size' then
            return
        end
    
        return OldIndex(...)
    end)
    ]]
    local OldNameCall = nil
    
    OldNameCall = hookmetamethod(game, '__namecall', function(...)
        local Args = {...}
    
    
        if not checkcaller() and getnamecallmethod() == 'GetPropertyChangedSignal' then
            warn('hooking2')
            wait(9e9)
        end
    
        return OldNameCall(...)
    end)
    pcall(function()local OldNameCall OldNameCall = hookmetamethod(game, '__namecall', function(...)    
        local args = {...}
        if getnamecallmethod() == 'FireServer' then
            if string.find(tostring(args[1]),'fearthe11') then
               return --nil   
        end
        end
           return OldNameCall(...)
        end)
        end)
    local GMT = getrawmetatable(game)
local NCO = GMT.__namecall
setreadonly(GMT, false)

GMT.__namecall = newcclosure(function(self, ...)
   local args = {...}
   if self.Name == "HumanoidRootPart" then
       if args[1] == "Velocity" then
           return
       end
   end
   return NCO(self, ...)
end)
setreadonly(GMT, true)
for _,v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
    v:Disable()
 end
 for _,v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
    v:Disable()
 end
 local mt = getrawmetatable(game)
 local old = mt.__namecall
 local protect = newcclosure or protect_function
 
 if not protect then
     protect = function(f) 
         return f 
     end
 end
 
 setreadonly(mt, false)
 mt.__namecall = protect(function(self, ...)
 local method = getnamecallmethod()
 
 if method == "Kick" then   
 wait(9e9)
         return
     end
     return old(self, ...)
 end)
 
 hookfunction(game:GetService("Players").LocalPlayer.Kick,protect(function() 
     wait(9e9) 
 end))
    end

    spawn(function()
    pcall(function()
    ugby = true
    spawn(function()
    bypassacs()
    end)
    end)
    end)

function prebypasses()
-- Pretty much just a bunch of know detection bypasses. (Big thanks to Lego Hacker, Modulus, Bluwu, and I guess Iris or something)

-- GCInfo/CollectGarbage Bypass (Realistic by Lego - Amazing work!)
task.spawn(function()
    repeat task.wait() until game:IsLoaded()

    local Amplitude = 200
    local RandomValue = {-15,15}
    local RandomTime = {.5, 1.5}

    local floor = math.floor
    local cos = math.cos
    local sin = math.sin
    local acos = math.acos
    local pi = math.pi

    local Maxima = 0

    --Waiting for gcinfo to decrease
    while task.wait() do
        if gcinfo() >= Maxima then
            Maxima = gcinfo()
        else
            break
        end
    end

    task.wait(0.30)

    local OldGcInfo = gcinfo()+Amplitude
    local tick = 0

    --Spoofing gcinfo
    local Old; Old = hookfunction(gcinfo, function(...)
        local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude )
        return floor(OldGcInfo + Formula)
    end)
    local Old2; Old2 = hookfunction(collectgarbage, function(arg, ...)
        local suc, err = pcall(Old2, arg, ...)
        if suc and arg == "collect" then
            return gcinfo(...)
        end
        return Old2(arg, ...)
    end)


    game:GetService("RunService").Stepped:Connect(function()
        local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude )
        if Formula > ((acos(cos(pi * (tick)+.01))/pi * (Amplitude * 2)) + -Amplitude ) then
            tick = tick + .07
        else
            tick = tick + 0.01
        end
    end)

    local old1 = Amplitude
    for i,v in next, RandomTime do
        RandomTime[i] = v * 10000
    end

    local RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000

    --I can make it 0.003 seconds faster, yea, sure
    while wait(RandomTime) do
        Amplitude = math.random(old1+RandomValue[1], old1+RandomValue[2])
        RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000
    end
end)

-- Memory Bypass
task.spawn(function()
    repeat task.wait() until game:IsLoaded()

    local RunService = cloneref(game:GetService("RunService"))
    local Stats = cloneref(game:GetService("Stats"))

    local CurrMem = Stats:GetTotalMemoryUsageMb();
    local Rand = 0

    RunService.Stepped:Connect(function()
        Rand = math.random(-3,3)
    end)

    local _MemBypass
    _MemBypass = hookmetamethod(game, "__namecall", function(self,...)
        local method = getnamecallmethod();

        if not checkcaller() then
            if typeof(self) == "Instance" and (method == "GetTotalMemoryUsageMb" or method == "getTotalMemoryUsageMb") and self.ClassName == "Stats" then
                return CurrMem + Rand;
            end
        end

        return _MemBypass(self,...)
    end)

    -- Indexed Versions
    local _MemBypassIndex; _MemBypassIndex = hookfunction(Stats.GetTotalMemoryUsageMb, function(self, ...)
        if not checkcaller() then
            if typeof(self) == "Instance" and self.ClassName == "Stats" then
                return CurrMem + Rand;
            end
        end
    end)
end)

-- ContentProvider Bypasses
local Content = cloneref(game:GetService("ContentProvider"));
local CoreGui = cloneref(game:GetService("CoreGui"));
local randomizedCoreGuiTable;
local randomizedGameTable;

local coreguiTable = {}

game:GetService("ContentProvider"):PreloadAsync({CoreGui}, function(assetId) --use preloadasync to patch preloadasync :troll:
    if not assetId:find("rbxassetid://") then
        table.insert(coreguiTable, assetId);
    end
end)
local gameTable = {}

for i, v in pairs(game:GetDescendants()) do
    if v:IsA("ImageLabel") then
        if v.Image:find('rbxassetid://') and v:IsDescendantOf(CoreGui) then else
            table.insert(gameTable, v.Image)
        end
    end
end

function randomizeTable(t)
    local n = #t
    while n > 0 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end
    return t
end

local ContentProviderBypass
ContentProviderBypass = hookmetamethod(game, "__namecall", function(self, Instances, ...)
    local method = getnamecallmethod();
    local args = ...;

    if not checkcaller() and (method == "preloadAsync" or method == "PreloadAsync") then
        if Instances and Instances[1] and self.ClassName == "ContentProvider" then
            if Instances ~= nil then
                if typeof(Instances[1]) == "Instance" and (table.find(Instances, CoreGui) or table.find(Instances, game)) then
                    if Instances[1] == CoreGui then
                        randomizedCoreGuiTable = randomizeTable(coreguiTable)
                        return ContentProviderBypass(self, randomizedCoreGuiTable, ...)
                    end

                    if Instances[1] == game then
                        randomizedGameTable = randomizeTable(gameTable)
                        return ContentProviderBypass(self, randomizedGameTable, ...)
                    end
                end
            end
        end
    end

    return ContentProviderBypass(self, Instances, ...)
end)

local preloadBypass; preloadBypass = hookfunction(Content.PreloadAsync, function(a, b, c)
    if not checkcaller() then
        if typeof(a) == "Instance" and tostring(a) == "ContentProvider" and typeof(b) == "table" then
            if (table.find(b, CoreGui) or table.find(b, game)) and not (table.find(b, true) or table.find(b, false)) then
                if b[1] == CoreGui then -- Double Check
                    randomizedCoreGuiTable = randomizeTable(coreguiTable)
                    return preloadBypass(a, randomizedCoreGuiTable, c)
                end
                if b[1] == game then -- Triple Check
                    randomizedGameTable = randomizeTable(gameTable)
                    return preloadBypass(a, randomizedGameTable, c)
                end
            end
        end
    end

    return preloadBypass(a, b, c)
end)

-- GetFocusedTextBox Bypass
local _IsDescendantOf = game.IsDescendantOf

local TextboxBypass
TextboxBypass = hookmetamethod(game, "__namecall", function(self,...)
    local method = getnamecallmethod();
    local args = ...;

    if not checkcaller() then
        if typeof(self) == "Instance" and method == "GetFocusedTextBox" and self.ClassName == "UserInputService" then
            local Textbox = TextboxBypass(self,...);
            if Textbox and typeof(Textbox) == "Instance" then
                local succ,err = pcall(function() _IsDescendantOf(Textbox, Bypassed_Dex) end)

                if err and err:match("The current identity") then
                    return nil;
                end
            end
        end
    end

    return TextboxBypass(self,...);
end)

--Newproxy Bypass (Stolen from Lego Hacker (V3RM))
local TableNumbaor001 = {}
local SomethingOld;
SomethingOld = hookfunction(getrenv().newproxy, function(...)
    local proxy = SomethingOld(...)
    table.insert(TableNumbaor001, proxy)
    return proxy
end)

local RunService = cloneref(game:GetService("RunService"))
RunService.Stepped:Connect(function()
    for i,v in pairs(TableNumbaor001) do
        if v == nil then end
    end
end)

end

    spawn(function()
    pcall(function()
    if premium or dev then
    prebypasses()
    pby = true
    end
    end)
    end)

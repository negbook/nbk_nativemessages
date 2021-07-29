local DrawText2D = function(text,scale,x,y,alpha)
    if alpha > 0 then 
    scale = scale or 15
	SetTextScale(scale/24, scale/24)
	SetTextFont(0)
	SetTextColour(255, 255, 255, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y, 0)
	--ClearDrawOrigin()
    end 
end
local DrawText3D = function(coords,text,scale,x,y,alpha)
    local camCoords = GetGameplayCamCoords()
    local distance = #(coords - camCoords)
    local scale = (scale / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov
    if alpha > 0 then 
    scale = scale or 15
	SetTextScale(scale/24, scale/24)
	SetTextFont(0)
	SetTextColour(255, 255, 255, alpha)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y, 0)
	--ClearDrawOrigin()
    end 
end
local DrawNextOrder = function(handle)
    return SetScriptGfxDrawOrder(handle%128)
end 
local hudmessage_handle = 1
local hudmessage_handles = {}
local hudmessage = function(text,xper,yper,scale,durationIn,durationHold,durationOut,cb)
    local object = {}
        object._text = text
        object._x = xper
        object._y = yper
        object._alpha = 0
        object._scale = scale
        if durationIn == nil then durationIn = 1500 end 
        if durationHold == nil then durationHold = 2500 end 
        if durationOut == nil then durationOut = 1500 end 
        durationIn = durationIn / 1000
        durationHold = durationHold / 1000
        durationOut = durationOut / 1000
        if hudmessage_handle > 65530 then hudmessage_handle = 1 end 
        hudmessage_handle = hudmessage_handle + 1
        hudmessage_handles[hudmessage_handle] = true 
        TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage_handle,cb)
            TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage_handle,cb)
                TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage_handle,cb)
                    hudmessage_handles[hudmessage_handle] = nil
                    if cb then 
                        cb(object)
                    end
                end ,onCompleteArgs={object,hudmessage_handle,cb}})
            end ,onCompleteArgs={object,hudmessage_handle,cb}})
        end ,onCompleteArgs={object,hudmessage_handle,cb}})
        hudmessage_handles[hudmessage_handle] = true 
        CreateThread(function() while hudmessage_handles[hudmessage_handle] do Wait(0)
            DrawNextOrder(hudmessage_handle)

            DrawText2D(object._text,object._scale,object._x,object._y,math.floor(object._alpha))
            end 
        end )
end
local hudmessage2_handle = 1
local hudmessage2_handles = {}
local hudmessage2 = function(text,coords,duration,cb)
    local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
    if bool then 
        local object = {}
        object._text = text
        object._x = xper
        object._y = yper
        object._alpha = 0
        object._scale = 15
        local durationIn,durationHold,durationOut
        if durationIn == nil then durationIn = duration end 
        if durationHold == nil then durationHold = 0 end 
        if durationOut == nil then durationOut = duration end 
        durationIn = durationIn / 1000
        durationHold = durationHold / 1000
        durationOut = durationOut / 1000
        if hudmessage2_handle > 65530 then hudmessage2_handle = 1 end 
        hudmessage2_handle = hudmessage2_handle + 1
        hudmessage2_handles[hudmessage2_handle] = true 
        TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage2_handle,cb)
            --TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage2_handle,cb)
                TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,hudmessage2_handle,cb)
                    hudmessage2_handles[hudmessage2_handle] = nil
                    if cb then 
                        cb(object)
                    end
                end ,onCompleteArgs={object,hudmessage2_handle,cb}})
            --end ,onCompleteArgs={object,hudmessage2_handle,cb}})
        end ,onCompleteArgs={object,hudmessage2_handle,cb}})
        hudmessage2_handles[hudmessage2_handle] = true 
        CreateThread(function() 
            
            while hudmessage2_handles[hudmessage2_handle] do Wait(0)
            DrawNextOrder(hudmessage2_handle)
            DrawText2D(object._text,object._scale,object._x,object._y,math.floor(object._alpha))
            end 
        end )
    end 
end
local coordsmessage_handle = 1
local coordsmessage_handles = {}
local coordsmessage = function(text,coords,duration,cb)
    local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
    if bool then 
        local object = {}
        object._text = text
        object._x = xper
        object._y = yper
        object._alpha = 0
        local _scale = 15
        object._scale = _scale
        local durationIn,durationHold,durationOut
        if durationIn == nil then durationIn = duration end 
        if durationHold == nil then durationHold = 0 end 
        if durationOut == nil then durationOut = duration end 
        durationIn = durationIn / 1000
        durationHold = durationHold / 1000
        durationOut = durationOut / 1000
        if coordsmessage_handle > 65530 then coordsmessage_handle = 1 end 
        coordsmessage_handle = coordsmessage_handle + 1
        coordsmessage_handles[coordsmessage_handle] = true 
        TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage_handle,cb)
            --TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage_handle,cb)
                TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage_handle,cb)
                    coordsmessage_handles[coordsmessage_handle] = nil
                    if cb then 
                        cb(object)
                    end
                end ,onCompleteArgs={object,coordsmessage_handle,cb}})
            --end ,onCompleteArgs={object,coordsmessage_handle,cb}})
        end ,onCompleteArgs={object,coordsmessage_handle,cb}})
        coordsmessage_handles[coordsmessage_handle] = true 

        CreateThread(function() while coordsmessage_handles[coordsmessage_handle] do Wait(0)
                DrawNextOrder(coordsmessage_handle)
                local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
                if bool then 
                    object._x,object._y = xper,yper
                    DrawText3D(coords,object._text,object._scale,object._x,object._y,math.floor(object._alpha))
                end

            end 
        end )
    end 
end

local coordsmessage2_handle = 1
local coordsmessage2_handles = {}
local coordsmessage2 = function(text,coords,duration,cb)
   
    local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
    if bool then 
        local object = {}
        object._text = text
        object._x = xper
        object._y = yper
        object._alpha = 0
        local _scale = 15
        object._scale = _scale
        local durationIn,durationHold,durationOut
        if durationIn == nil then durationIn = duration end 
        if durationHold == nil then durationHold = 0 end 
        if durationOut == nil then durationOut = duration end 
        durationIn = durationIn / 1000
        durationHold = durationHold / 1000
        durationOut = durationOut / 1000
        if coordsmessage2_handle > 65530 then coordsmessage2_handle = 1 end 
        coordsmessage2_handle = coordsmessage2_handle + 1
        
        Threads.AddPosition("coordsmessage2"..coordsmessage2_handle,coords,20.0,function(result)
            
            if result.action == 'enter' then 
                
                coordsmessage2_handles[coordsmessage2_handle] = "unshow"
                TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage2_handle,cb)
                    coordsmessage2_handles[coordsmessage2_handle] = "show" 
                end,onCompleteArgs={object,coordsmessage2_handle,cb}})
                Threads.CreateLoopOnce("coordsmessage2"..coordsmessage2_handle,0,function(Break)
                    if coordsmessage2_handles[coordsmessage2_handle]=="unshow" then 
                        DrawNextOrder(coordsmessage2_handle)
                        local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
                        if bool then 
                            object._x,object._y = xper,yper
                            DrawText3D(coords,object._text,object._scale,object._x,object._y,math.floor(object._alpha))
                        end
                    elseif coordsmessage2_handles[coordsmessage2_handle]=="show" then 
                        local distance = #(GetEntityCoords(PlayerPedId()) - coords)
                        
                        if distance < 8 then 
                            DrawNextOrder(coordsmessage2_handle)
                            local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
                            if bool then 
                                object._x,object._y = xper,yper
                                DrawText3D(coords,object._text,object._scale,object._x,object._y,math.floor(object._alpha))
                            else 
                                TweenCFX.Tween.removeTween(object)
                                object._alpha = 0
                                coordsmessage2_handles[coordsmessage2_handle] = "hide" 
                            end 
                        else 
                            coordsmessage2_handles[coordsmessage2_handle] = "unshow" 
                            TweenCFX.Tween.to(object,durationIn,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage2_handle,cb)
                                coordsmessage2_handles[coordsmessage2_handle] = "hide" 
                            end,onCompleteArgs={object,coordsmessage2_handle,cb}})
                        end 
                    elseif coordsmessage2_handles[coordsmessage2_handle]=="hide" then 
                        local distance = #(GetEntityCoords(PlayerPedId()) - coords)
                        if distance < 8 then 
                            local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z)
                            if bool then 
                                coordsmessage2_handles[coordsmessage2_handle] = "unshow" 
                                TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,coordsmessage2_handle,cb)
                                    coordsmessage2_handles[coordsmessage2_handle] = "show" 
                                end,onCompleteArgs={object,coordsmessage2_handle,cb}})
                            else 
                                TweenCFX.Tween.removeTween(object)
                                object._alpha = 0
                                coordsmessage2_handles[coordsmessage2_handle] = "hide" 
                            end  
                        end 
                    elseif coordsmessage2_handles[coordsmessage2_handle]=="shoudkill" then  
                        Break()
                    end 
                end )
            elseif result.action == 'exit' then 
                coordsmessage2_handles[coordsmessage2_handle] = "shoudkill"
            end 
        end)
    end 
end

local entitymessage_handle = 1
local entitymessage_handles = {}
local entitymessage = function(entity,text,duration,cb)
        local coords = GetEntityCoords(entity)
        local model = GetEntityModel(entity)
        local z1,z2 = GetModelDimensions(model)
        local heightz = IsEntityAPed(entity) and 0 or math.max(z1.z,z2.z) 
        local height = GetEntityHeightAboveGround(entity) + heightz
        local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z + height )
        if bool then 
            local object = {}
            object._text = text
            object._x = xper
            object._y = yper
            object._alpha = 0
            object._scale = 15
            local durationIn,durationHold,durationOut
            if durationIn == nil then durationIn = 1000 end 
            if durationHold == nil then durationHold = duration end 
            if durationOut == nil then durationOut = 1000 end 
            durationIn = durationIn / 1000
            durationHold = durationHold / 1000
            durationOut = durationOut / 1000
            if entitymessage_handle > 65530 then entitymessage_handle = 1 end 
            entitymessage_handle = entitymessage_handle + 1
            entitymessage_handles[entitymessage_handle] = {entity ,object}
            TweenCFX.Tween.to(object,durationIn,{_alpha=255,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entitymessage_handle,cb)
                TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entitymessage_handle,cb)
                    TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entitymessage_handle,cb)
                        entitymessage_handles[entitymessage_handle] = nil
                        if cb then 
                            cb(object)
                        end
                    end ,onCompleteArgs={object,entitymessage_handle,cb}})
                end ,onCompleteArgs={object,entitymessage_handle,cb}})
            end ,onCompleteArgs={object,entitymessage_handle,cb}})
            entitymessage_handles[entitymessage_handle] = {entity ,object}

            CreateThread(function() while entitymessage_handles[entitymessage_handle] do Wait(0)
                    if IsEntityOnScreen(entity) then 
                        
                    
                    local coords = GetEntityCoords(entity)
                    
                    local height = GetEntityHeightAboveGround(entity) + heightz
                    local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z + height )
                    if bool then 
                        object._x,object._y = xper,yper
                    end 
                    DrawNextOrder(entitymessage_handle)
                    DrawText2D(object._text,object._scale,object._x,object._y,math.floor(object._alpha))
                    end 

                end 
            end)
        end 
end
local entitymessageend = function(entity,cb)
    for i,v in pairs(entitymessage_handles) do 
        if v[1] == entity then 
            TweenCFX.Tween.removeTween(v[2])
            entitymessage_handles[entitymessage_handle] = nil
            break 
        end 
    end 
end
local entityquickmessage_handle = 1
local entityquickmessage_handles = {}
local entityquickmessage = function(entity,text,duration,cb)
        local coords = GetEntityCoords(entity)
        local model = GetEntityModel(entity)
        local z1,z2 = GetModelDimensions(model)
        local heightz = IsEntityAPed(entity) and 0 or math.max(z1.z,z2.z) 
        local height = GetEntityHeightAboveGround(entity) + heightz
        local bool,xper,yper = GetScreenCoordFromWorldCoord(coords.x,coords.y,coords.z + height )
        if bool then 
            local object = {}
            object._text = text
            object._x = xper
            object._y = yper
            object._alpha = 255
            object._scale = 15
            local durationIn,durationHold,durationOut
            if durationIn == nil then durationIn = duration end 
            if durationHold == nil then durationHold = 0 end 
            if durationOut == nil then durationOut = duration end 
            durationIn = durationIn / 1000
            durationHold = durationHold / 1000
            durationOut = durationOut / 1000
            if entityquickmessage_handle > 65530 then entityquickmessage_handle = 1 end 
            entityquickmessage_handle = entityquickmessage_handle + 1
            entityquickmessage_handles[entityquickmessage_handle] = true 
            TweenCFX.Tween.to(object,durationIn,{_y = object._y - 0.05,_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entityquickmessage_handle,cb)
                --TweenCFX.Tween.delayCall(object,durationHold,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entityquickmessage_handle,cb)
                    --TweenCFX.Tween.to(object,durationOut,{_alpha=0,ease=TweenCFX.Ease.LinearNone,onCompleteScope=function(object,entityquickmessage_handle,cb)
                        entityquickmessage_handles[entityquickmessage_handle] = nil
                        if cb then 
                            cb(object)
                        end
                    --end ,onCompleteArgs={object,entityquickmessage_handle,cb}})
                --end ,onCompleteArgs={object,entityquickmessage_handle,cb}})
            end ,onCompleteArgs={object,entityquickmessage_handle,cb}})
            entityquickmessage_handles[entityquickmessage_handle] = entity 

            CreateThread(function() while entityquickmessage_handles[entityquickmessage_handle] do Wait(0)
                    DrawNextOrder(entityquickmessage_handle)
                    DrawText2D(object._text,object._scale,object._x,object._y,math.floor(object._alpha))

                end 
            end)
        end 
end
exports('hudmessage', function (...)
    return hudmessage(...)
end )
exports('hudmessage2', function (...)
    return hudmessage2(...)
end )
exports('coordsmessage', function (...)
    return coordsmessage(...)
end )

exports('coordsmessage2', function (...)
    return coordsmessage2(...)
end )

exports('entityquickmessage', function (...)
    return entityquickmessage(...)
end )
exports('entitymessage', function (...)
    return entitymessage(...)
end )
exports('entitymessageend', function (...)
    return entitymessageend(...)
end )

RegisterNetEvent('hudmessage', function (...)
    hudmessage(...)
end )
RegisterNetEvent('hudmessage2', function (...)
    hudmessage2(...)
end )
RegisterNetEvent('coordsmessage', function (...)
    coordsmessage(...)
end )

RegisterNetEvent('coordsmessage2', function (...)
    return coordsmessage2(...)
end )

RegisterNetEvent('entityquickmessage', function (...)
    entityquickmessage(...)
end )
RegisterNetEvent('entitymessage', function (...)
    entitymessage(...)
end )
RegisterNetEvent('entitymessageend', function (...)
    entitymessageend(...)
end )


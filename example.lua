
CreateThread(function()
    exports.nbk_nativemessages:hudmessage("IV Tower",0.8,0.5,32,1000,2500,1000,function()
        print("Cool1")
    end)

end)

CreateThread(function()
    exports.nbk_nativemessages:hudmessage2("Hey You",GetEntityCoords(PlayerPedId())+1.0,2500,function()
        print("Cool2")
    end)
end)

CreateThread(function()
    TriggerEvent('coordsmessage',"Hey You2",GetEntityCoords(PlayerPedId())+1.0,2500,function()
        print("Cool3")
    end)
end)

CreateThread(function()
    TriggerEvent('coordsmessage2',"Hey You3",GetEntityCoords(PlayerPedId())+2.0,500,function()
        print("Cool3")
    end)
    
end)



local LastSeen = 0
local vehs = {}
CreateThread(function()

    while true do Wait(1000)
        vehs = GetGamePool("CVehicle")
    end 
end)

CreateThread(function()
    
    while true do Wait(1000)
        for i=1,#vehs do 
            local entity = vehs[i]
            local ped = PlayerPedId()
            if IsEntityAVehicle(entity) then 
                local vehicleCoords = GetEntityCoords(entity)
                local CamFov = GetGameplayCamFov() + GetEntitySpeed(ped) * 0.7
                local bool,x,y = GetScreenCoordFromWorldCoord(vehicleCoords.x,vehicleCoords.y,vehicleCoords.z)
                local hit = HasEntityClearLosToEntity(ped,entity,17)

                if bool and hit and x > 0.4 and x<0.6 and y < 0.8 and y > 0.2  then 

                    local retval = #(GetEntityCoords(ped) - vehicleCoords) < CamFov  
                    
                    if retval and not IsPedInVehicle(ped,entity) and LastSeen == 0 then 
                        if DoesEntityExist(LastSeen) then 
                            TriggerEvent('entitymessageend',LastSeen)
                        end 
                        LastSeen = entity 
                        local model = GetEntityModel(entity)
                        local name = GetStreetNameFromHashKey(GetHashKey(GetDisplayNameFromVehicleModel(model)))
                        local class = GetVehicleClassFromName(model)
                        local classname = GetStreetNameFromHashKey(GetHashKey('VEH_CLASS_'..class))
                        TriggerEvent('entitymessage',entity,"<font color='#cccccc'>".. name.."," .. classname .."</font>",3000,function()
                            
                        end)
                    else 
                        LastSeen = 0
                    end 
                end 
            end 
        end 
    end 
end)

CreateThread(function()
    
    TriggerEvent('hudmessage',"IV Tower2",0.8,0.5,32,1000,2500,1000)
    
end)


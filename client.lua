Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()

        if IsPedInAnyVehicle(playerPed, false) then
            Citizen.Wait(1)
            if IsControlJustPressed(0, 75) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)

                local seatIndex = nil
                for i = -1, 5 do
                    if GetPedInVehicleSeat(vehicle, i) == playerPed then
                        seatIndex = i
                        break
                    end
                end

                local targetPos = nil
                if seatIndex and seatIndex < 0 then
                    targetPos = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, 0.0, 0.0)
                else
                    targetPos = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, 0.0, 0.0)
                end

                ClearPedTasksImmediately(playerPed)
                TaskLeaveVehicle(playerPed, vehicle, 0)
                Citizen.Wait(10)

                SetEntityCoords(playerPed, targetPos.x, targetPos.y, targetPos.z)
                SetEntityHeading(playerPed, GetEntityHeading(vehicle))

                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(500)
        end
    end
end)

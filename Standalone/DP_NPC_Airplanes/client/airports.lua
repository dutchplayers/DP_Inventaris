Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		if current_departure and current_destination then
			if not landing then
				if IsEntityInAir(AirPlane) then
					SetVehicleLandingGear(AirPlane, 1)
				end
				if IsEntityInZone(AirPlane, current_destination.Zone) then
					x1, y1, z1 = table.unpack(departure.RunWayStart)
					x2, y2, z2 = table.unpack(departure.RunWayEnd)
					TaskPlaneLand(pilot, AirPlane, x1, y1, z1, x2, y2, z2)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			end
			if not IsEntityInZone(PlayerPedId(), current_departure.Zone) then
				if not IsEntityInAir(AirPlane) and IsPedInVehicle(PlayerPedId(), AirPlane, false) then
					TaskVehicleTempAction(pilot, Airplane, 27, -1)
					SetVehicleHandbrake(AirPlane, true)
					if GetEntitySpeed(AirPlaine) == 0.0 then
						if IsEntityInZone(PlayerPedId(), current_destination.Zone) then
							Wait(500)
							DoScreenFadeOut(200)
							while not IsScreenFadedOut() do
								Citizen.Wait(0)
							end
							DeleteVehicle(AirPlane)
							DeleteEntity(pilot)
							if current_destination.PlayerDropOff then
								x, y, z = table.unpack(current_destination.PlayerDropOff[1])
								SetEntityCoords(PlayerPedId(), x, y, z)
								SetEntityHeading(PlayerPedId(), current_destination.PlayerDropOff[2])
							end
							Wait(800)
							DoScreenFadeIn(500)
						else
							TaskLeaveVehicle(PlayerPedId(), AirPlane, 0)
							Wait(5000)
							DeleteVehicle(AirPlane)
							DeleteEntity(pilot)
						end
					end
				end
				if not IsPedInVehicle(PlayerPedId(), AirPlane, false) and landing == true then
					SetVehicleHandbrake(AirPlane, false)
					SetBlockingOfNonTemporaryEvents(pilot, false)
					SetEntityAsNoLongerNeeded(pilot)
					SetEntityAsNoLongerNeeded(AirPlane)
					current_departure = nil
					current_destination = nil
					landing = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		local playerCoords = GetEntityCoords(PlayerPedId(), true)
		for k,v in pairs(Config.Airports) do
			v = Config.Airports[k]
			x, y, z = table.unpack(v.Ticket)
			local distance = GetDistanceBetweenCoords(playerCoords, x, y, z, true)
			if distance < 2.0 then
				if IsControlPressed(0,46) then
					if Config.ESXMenu then
						OpenMenu()
					else
						CreateNativeMenu()
							
					end
					ClearAllHelpMessages()
				end
				if Config.ESXMenu or not _menuPool:IsAnyMenuOpen() then
					if not IsHelpMessageBeingDisplayed() then
						BeginTextCommandDisplayHelp("STRING")
						AddTextComponentSubstringPlayerName(GetLabelText("MATC_DPADRIGHT"))
						EndTextCommandDisplayHelp(0, 0, 1, -1)
					end
				end
			else if distance < 80.0 then
				if not IsPedInAnyPlane(PlayerPedId()) then
					if Config.ESXMenu or not _menuPool:IsAnyMenuOpen() then
						DrawMarker(1, x, y, z-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 219, 77, 155, 0, 0, 2, 0, 0, 0, 0)
					end
				end
			end
		end
		end
	end
end)
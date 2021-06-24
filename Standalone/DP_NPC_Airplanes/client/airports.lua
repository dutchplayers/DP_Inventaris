

function tprint (tbl, indent)
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		formatting = string.rep("  ", indent) .. k .. ": "
		if type(v) == "table" then
		print(formatting)
		tprint(v, indent+1)
		elseif type(v) == 'boolean' then
		print(formatting .. tostring(v))      
		else
		print(formatting .. v)
		end
	end
end

function ChangeTask(task, keepTask) -- , x, y, z
	print("ChangeTask")
	tprint(current.task)
	current.task.name = task
	if task == "TaskVehicleDriveToCoordLongrange" then
		local planeModel = GetEntityModel(current.plane)
		local _, runway = next(current.destination.Runways)
		local _, direction = next(runway, 1)
		local x, y, z, w = table.unpack(direction)
		DebugTarget(x,y,z,"TaskVehicleDriveToCoordLongrange")
		ControlLandingGear(current.plane, 0)
		TaskVehicleDriveToCoordLongrange(current.pilot, current.plane, x, y, z, GetVehicleModelMaxSpeed(planeModel), 16777216, 0.0)
	elseif task == "TaskPlaneMission" then
		local planeModel = GetEntityModel(current.plane)
		local _, runway = next(current.destination.Runways)
		local _, direction = next(runway)
		local x, y, z, w = table.unpack(direction) -- TaskPlaneMission
		z = z + 50
		DebugTarget(x,y,z,"TaskPlaneMission")
		TaskPlaneMission(current.pilot, current.plane, 0, 0, x, y, z, 4, GetVehicleModelMaxSpeed(planeModel), 1.0, 0.0, 10.0, 40.0)
	elseif task == "TaskPlaneLand" then
		local x1, y1, z1 = table.unpack(current.destination.RunWayStart)
		local x2, y2, z2 = table.unpack(current.destination.RunWayEnd)
		DebugTarget(x1,y1,z1,"TaskPlaneLand RunWayStart")
		DebugTarget(x2,y2,z2,"TaskPlaneLand RunWayEnd")
		TaskPlaneLand(current.pilot, current.plane, x1, y1, z1, x2, y2, z2)
		ControlLandingGear(current.plane, 0)
		current.landing = true
	end
	if keepTask then SetPedKeepTask(current.pilot, true) else SetPedKeepTask(current.pilot, false) end
end

function DebugTarget(x,y,z,title)
	blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, 38)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, .3)
	-- SetBlipColour(blip, colour)
	-- SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(title)
	EndTextCommandSetBlipName(blip)
	table.insert(current.blips, blip)
end
function ClearBlips()
	for i, blip in ipairs(current.blips) do
		SetBlipSprite(blip, 37)
		SetBlipScale(blip, 0.0)
	end
	current.blips = {}
end
function DebugBlips()
	for airport_name, airport in pairs(Config.Airports) do
		print("Airport: " .. airport_name)
		for variable_name, value in pairs(airport) do
			DebugBlip(value, airport_name .. " " .. variable_name)
		end
		for runway_name, runway in pairs(airport.Runways) do
			print("- Runway: " .. runway_name)
			for runway_direction_name, point in pairs(runway) do
				print("-- Direction: " .. runway_direction_name)
				-- for point_direction_name, point in pairs(runway_direction) do
				DebugBlip(point, airport_name .. " runway " .. runway_name .. " " .. runway_direction_name)
				-- end
			end
		end
	end
end
function DebugBlip(value, text)
	local x, y, z, w
	if type(value) == "vector3" then x, y, z = table.unpack(value) end
	if type(value) == "vector4" then x, y, z, w = table.unpack(value) end
	if x then DebugTarget(x,y,z,text) end
end
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()));
		local zone = GetNameOfZone(x, y, z);
		local zoneLabel = GetLabelText(zone);
		print("LOCATION: " .. x .. " " .. y .. " " .. z .. " zone: " .. zone .. " (" .. zoneLabel .. ")")
		if current.departure and current.destination then
			print("has current.departure and current.destination")
			if not current.landing then
				if IsEntityInAir(current.plane) then
					print("current.plane is in air!")
					SetVehicleLandingGear(current.plane, 1)
				end
				if IsEntityInZone(current.plane, current.destination.Zone) then
					print("current.plane is not current.landing but in destination zone!")
					ChangeTask("TaskPlaneLand", true)
				end
			end
			local pedId = PlayerPedId()
			if not IsEntityInZone(pedId, current.departure.Zone) then
				print("player is not in current.departure.Zone!")
				if not IsEntityInAir(current.plane) and IsPedInVehicle(pedId, current.plane, false) then
					print("current.plane is not in air and ped not in current.plane!")
					TaskVehicleTempAction(current.pilot, current.plane, 27, -1)
					SetVehicleHandbrake(current.plane, true)
					if GetEntitySpeed(AirPlaine) == 0.0 then
						if IsEntityInZone(pedId, current.destination.Zone) then
							Wait(500)
							DoScreenFadeOut(200)
							while not IsScreenFadedOut() do
								Citizen.Wait(0)
							end
							DeleteVehicle(current.plane)
							DeleteEntity(current.pilot)
							if current.destination.PlayerDropOff then
								x, y, z = table.unpack(current.destination.PlayerDropOff[1])
								SetEntityCoords(pedId, x, y, z)
								SetEntityHeading(pedId, current.destination.PlayerDropOff[2])
							end
							Wait(800)
							DoScreenFadeIn(500)
						else
							TaskLeaveVehicle(pedId, current.plane, 0)
							Wait(5000)
							DeleteVehicle(current.plane)
							DeleteEntity(current.pilot)
						end
					end
				end
				if not IsPedInVehicle(pedId, current.plane, false) and current.landing == true then
					print("player is not in current.plane but current.landing!")
					SetVehicleHandbrake(current.plane, false)
					SetBlockingOfNonTemporaryEvents(current.pilot, false)
					SetEntityAsNoLongerNeeded(current.pilot)
					SetEntityAsNoLongerNeeded(current.plane)
					current.departure = nil
					current.destination = nil
					current.landing = false
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
function PreparePlane(departure, destination, route)
	print("PreparePlane " .. tostring(departure) .. tostring(destination) .. tostring(route))
	if Config.UseESX then
		TriggerServerEvent('airports:payTicket', departure, destination, route)
	else
		CreatePlane(departure, destination, route)
	end
end
current.pilot = nil
function CreatePlane(departure, destination, route)
	print("CreatePlane " .. tostring(departure) .. " | " .. tostring(destination) .. " | " .. tostring(route))
	current.departure = departure
	current.destination = destination
	if not Config.ESXMenu and mainMenu then
		mainMenu:Visible(false)
	end

	local planeModel = GetHashKey(route.Planes[math.random(#route.Planes)])
	local pilotModel = GetHashKey(route.Pilots[math.random(#route.Pilots)])
	
	RequestModel(planeModel)
	RequestModel(pilotModel)
	while not HasModelLoaded(planeModel) or not HasModelLoaded(pilotModel) do
		Citizen.Wait(0)
	end

	local start_runway_name, runway = next(departure.Runways)
	local start_direction_name, direction = next(runway)
	local x, y, z, h = table.unpack(direction)
	-- local x, y, z = table.unpack(departure.PlaneSpawn[1])
	local h = h + 180 -- departure.PlaneSpawn[2]
	local pedId = PlayerPedId()
	SetEntityCoords(pedId, x, y, z)
	ClearAreaOfEverything(x, y, z, 1500, false, false, false, false, false)

	print("CreateVehicle start_runway_name " .. start_runway_name .. " start_direction_name " .. start_direction_name)
	current.plane = CreateVehicle(planeModel, x, y, z-1.0, h, true, false)
	ControlLandingGear(current.plane, 0)
	SetVehicleOnGroundProperly(current.plane)
	SetVehicleEngineOn(current.plane, true, true, true)
	SetEntityProofs(current.plane, true, true, true, true, true, true, true, false)
	SetVehicleHasBeenOwnedByPlayer(current.plane, true)

	current.pilot = CreatePedInsideVehicle(current.plane, 6, pilotModel, -1, true, false)

	SetBlockingOfNonTemporaryEvents(current.pilot, true)

	local netVehid = NetworkGetNetworkIdFromEntity(current.plane)
	SetNetworkIdCanMigrate(netVehid, true)
	NetworkRegisterEntityAsNetworked(VehToNet(current.plane))

	local netPedid = NetworkGetNetworkIdFromEntity(current.pilot)
	SetNetworkIdCanMigrate(netPedid, true)
	NetworkRegisterEntityAsNetworked(current.pilot)

	TaskWarpPedIntoVehicle(pedId, current.plane, -2)

	SetModelAsNoLongerNeeded(planeModel)
	SetModelAsNoLongerNeeded(pilotModel)
	-- ChangeTask("TaskVehicleDriveToCoordLongrange", false)
	local planeModel = GetEntityModel(current.plane)
	local liftoff_direction_name, newdirection
	for k, _direction in pairs(runway) do
		if _direction ~= direction then
			liftoff_direction_name = k
			newdirection = _direction
		end
	end
	tprint(newdirection)
	x, y, z, h = table.unpack(newdirection[1])
	ControlLandingGear(current.plane, 0)
	print("TaskVehicleDriveToCoordLongrange start_runway_name " .. start_runway_name .. " liftoff_direction_name " .. liftoff_direction_name)
	TaskVehicleDriveToCoordLongrange(current.pilot, current.plane, x, y, z, GetVehicleModelMaxSpeed(planeModel), 16777216, 0.0)
	Wait(10000)
	x, y, z, h = table.unpack(newdirection[2]) -- HIER WEITER MACHEN
	ControlLandingGear(current.plane, 0)
	print("TaskPlaneMission start_runway_name " .. start_runway_name .. " liftoff_direction_name " .. liftoff_direction_name)
	TaskPlaneMission(current.pilot, current.plane, 0, 0, x, y, z, 4, GetVehicleModelMaxSpeed(planeModel), 1.0, 0.0, 10.0, 40.0)
	Wait(15000)
	-- ChangeTask("TaskPlaneMission", true)
	local end_runway_name, runway = next(destination.Runways)
	local end_direction_name, direction = next(runway)
	print("TaskPlaneMission end_runway_name " .. end_runway_name .. " end_direction_name " .. end_direction_name)
	x, y, z, h = table.unpack(direction)
	TaskPlaneMission(current.pilot, current.plane, 0, 0, x, y, z, 4, GetVehicleModelMaxSpeed(planeModel), 1.0, 0.0, 10.0, 40.0)
	SetPedKeepTask(current.pilot, true)
	current.flying = true
	tprint(current)
end

RegisterNetEvent("airports:departure")
AddEventHandler("airports:departure",  function(departure, destination, route)
	print("airports:departure " .. tostring(departure) .. tostring(destination) .. tostring(route))
	ClearAllHelpMessages()
	CreatePlane(departure, destination, route)
end)
function PreparePlane(departure, destination, route)
	if Config.UseESX then
		TriggerServerEvent('airports:payTicket', departure, destination, route)
	else
		CreatePlane(departure, destination, route)
	end
end

function CreatePlane(departure, destination, route)
	print("Creating plane ")
	local x, y, z = table.unpack(departure.PlaneSpawn[1])
	local h = departure.PlaneSpawn[2]
	current_departure = departure
	current_destination = destination
	if not Config.ESXMenu then
		mainMenu:Visible(false)
	end

	modelHash = GetHashKey(route.Planes[math.random(#route.Planes)])
	pilotModel = GetHashKey(route.Pilots[math.random(#route.Pilots)])
	
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Citizen.Wait(0)
	end

	RequestModel(pilotModel)
	while not HasModelLoaded(pilotModel) do
		Citizen.Wait(0)
	end
	SetEntityCoords(PlayerPedId(), x, y, z)
	if HasModelLoaded(modelHash) and HasModelLoaded(pilotModel) then
		ClearAreaOfEverything(x, y, z, 1500, false, false, false, false, false)

		AirPlane = CreateVehicle(modelHash, x, y, z-1.0, h, true, false)
		ControlLandingGear(AirPlane, 0)
		SetVehicleOnGroundProperly(AirPlane)
		SetVehicleEngineOn(AirPlane, true, true, true)
		SetEntityProofs(AirPlane, true, true, true, true, true, true, true, false)
		SetVehicleHasBeenOwnedByPlayer(AirPlane, true)

		local pilot = CreatePedInsideVehicle(AirPlane, 6, pilotModel, -1, true, false)

		SetBlockingOfNonTemporaryEvents(pilot, true)

		local netVehid = NetworkGetNetworkIdFromEntity(AirPlane)
		SetNetworkIdCanMigrate(netVehid, true)
		NetworkRegisterEntityAsNetworked(VehToNet(AirPlane))

		local netPedid = NetworkGetNetworkIdFromEntity(pilot)
		SetNetworkIdCanMigrate(netPedid, true)
		NetworkRegisterEntityAsNetworked(pilot)

		TaskWarpPedIntoVehicle(PlayerPedId(), AirPlane, -2)

		SetModelAsNoLongerNeeded(modelHash)
		SetModelAsNoLongerNeeded(pilotModel)
	end

	local x1, y1, z1 = table.unpack(departure.TaskVehicleDriveToCoordLongrange)
	local x2, y2, z2 = table.unpack(departure.TaskPlaneMission)
	TaskVehicleDriveToCoordLongrange(pilot, AirPlane, x1, y1, z1, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
	ControlLandingGear(AirPlane, 0)
	Wait(15000)
	TaskPlaneMission(pilot, AirPlane, 0, 0, x2, y2, z2, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 10.0, 40.0)
end

RegisterNetEvent("airports:departure")
AddEventHandler("airports:departure",  function(departure, destination, route)
	ClearAllHelpMessages()
	CreatePlane(departure, destination, route)
end)
local function GetRoutesForCurrentPosition()
	local result = {
		departure = nil,
		arrivals = {}
	}
	for k, departure in pairs(Config.Airports) do
		if IsEntityInZone(PlayerPedId(), departure.Zone) then
			result.departure = departure
			for k, arrival in pairs(departure.Destinations) do
				result.arrivals[k] = { arrival, Config.Airports[k] }
			end
		end
	end
	return result
end
local menuOpen = false
mainMenu = nil
if Config.ESXMenu then
	function OpenMenu()
		if menuOpen then return end
		menuOpen = true
		elements = {}
		local routes = GetRoutesForCurrentPosition()
		for k, v in pairs(routes.arrivals) do
			table.insert(elements, {
				label = v[2].Name,
				type  = k
			})
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'npcplane',
		{
			title    = Config.Locale.MenuTitle,
			align    = Config.ESXMenuAlign,
			elements = elements
		}, function(data, menu)
			local type = data.current.type
			local routes = GetRoutesForCurrentPosition()
			PreparePlane(routes.departure, routes.arrivals[type], Config.Airports[type[3]])
			menuOpen = false
			menu.close()
			return
		end, function(data, menu)
			menuOpen = false
			menu.close()
		end)
	end
else
	_menuPool = NativeUI.CreatePool()
	menu_items = {}
	function CreateNativeMenu()
		_menuPool:Clear()
		mainMenu = NativeUI.CreateMenu("", Config.Locale.MenuTitle, "", "", "shopui_title_exec_vechupgrade", "shopui_title_exec_vechupgrade")
		_menuPool:Add(mainMenu)

		_menuPool:ControlDisablingEnabled(false)
		_menuPool:MouseControlsEnabled(false)


		function AddAirPortMenu(menu)
			menu_items = {}
			for key, departure in pairs(Config.Airports) do
				if IsEntityInZone(PlayerPedId(), departure.Zone) then
					for k, v in pairs(departure.Destinations) do
						local item = NativeUI.CreateItem(Config.Airports[k].Name)
						if Config.UseESX then item = NativeUI.CreateItem(Config.Airports[k].Name, Config.Locale.Money .. v.Price .. Config.Locale.MoneyCurrency) end
						menu_items[k] = item
						menu:AddItem(item)
					end
					return
				end
			end
			menu.OnItemSelect = function(sender, item, index)
				print("menu.OnItemSelect")
				print(item.Text._Text) -- item.Text._Text
				arrival = nil
				for k, _arrival in pairs(Config.Airports) do
					if _arrival.Name == item.Text._Text then
						arrival = arrival
						break
					end
				end
				-- for k, arrival in pairs(Config.Airports) do
					-- if item.Text._Text == Config.Airports[k] then
						for k, departure in pairs(arrival.Destinations) do
							print(k)
							if IsEntityInZone(PlayerPedId(), departure.Zone) then
								PreparePlane(departure, arrival, departure.Destinations[item.Text._Text])
								menu.close()
							return
							end
						end
					-- end
				-- end
			end   
		end
		AddAirPortMenu(mainMenu)
		_menuPool:RefreshIndex()
		mainMenu:Visible(true) -- not mainMenu:Visible()
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			_menuPool:ProcessMenus()
		end
	end)
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then return end
	print('The resource ' .. resourceName .. ' was stopped.')
	ClearBlips()
end)  

RegisterCommand('aptest', function()
	print("aptest")
	local departure = Config.Airports["ssa"]
	print("departure " .. departure.Name)
	local arrival = Config.Airports["lsia"]
	print("arrival " .. arrival.Name)
	local route = departure.Destinations["lsia"]
	print("route price" .. tostring(route.Price))
	PreparePlane(departure, arrival, route)
end, false)

RegisterCommand('apc', function()
	print("-- current --")
	tprint(current.task)
	print("-- current --")
end, false)

RegisterCommand('apclear', function()
	ClearBlips()
end, false)

RegisterCommand('apb', function()
	DebugBlips()
end, false)
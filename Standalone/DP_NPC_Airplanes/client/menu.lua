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
			print("ESX.UI.Menu.Open")
			local type = data.current.type
			print(type)
			local routes = GetRoutesForCurrentPosition()
			-- local departure = type[1]
			-- print(departure.Name)
			-- local destination = type[2]
			-- CreatePlane(departure, destination, Config.Airports[type[3]])
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
				print(item)
				for key, menu_item in pairs(menu_items) do
					print(key)
					print(menu_item)
					if menu_item == item then
						for k, departure in pairs(Config.Airports[key].Destinations) do
							print(k)
							if IsEntityInZone(PlayerPedId(), departure.Zone) then
								CreatePlane(departure, Config.Airports[key], departure.Destinations[key])
								menu.close()
							return
							end
						end
					end
				end
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
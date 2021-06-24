if Config.UseESX then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent("airports:payTicket")
	AddEventHandler("airports:payTicket", function(departure, destination, route)
		if Config.UseESX then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getAccount('money').money >= route.Price then
				xPlayer.removeAccountMoney('money', route.Price)
				TriggerClientEvent("airports:departure", departure, destination, route)
			elseif xPlayer.getAccount('bank').money >= route.Price then
				xPlayer.removeAccountMoney('bank', route.Price)
				TriggerClientEvent("airports:departure", departure, destination, route)
			else
				TriggerClientEvent("airports:moneyInvalid", _source)
			end
		end		
	end)
end
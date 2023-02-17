local QBCore = exports['qb-core']:GetCoreObject()

--Consumables

--Worth a try
CreateThread(function()
	local drinks = { "sprunk", "sprunklight", "ecola", "ecolalight", "popshake", "coffee" }
    for k,v in pairs(drinks) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('qb-popsdiner:client:Drink', source, item.name) end) end
	
	local food = { "crisps", "carrotcake", "cheesecake", "jelly", "chocpudding", "popdonut", "popicecream", "chocolate", 
					"baconeggs", "bltsandwich", "cheeseburger", "cheesesandwich", "eggsandwich", "grilledwrap", "hamburger", 
					"hamcheesesandwich", "hamsandwich", "ranchwrap", "sausageeggs", "steakburger", "toastbacon", "tunasandwich", "veggiewrap" }
    for k,v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('qb-popsdiner:client:Eat', source, item.name) end) end
end)

RegisterServerEvent('qb-popsdiner:GetFood')
AddEventHandler('qb-popsdiner:GetFood', function(ItemMake)
    local Player = QBCore.Functions.GetPlayer(source)
	--FOOD
	if ItemMake == "baconeggs" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ham'], "remove", 1) 
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['jimeggs'], "remove", 1) 
		Player.Functions.RemoveItem('ham', 1)
		Player.Functions.RemoveItem('jimeggs', 1)
	elseif ItemMake == "bltsandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ham'], "remove", 1) 
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lettuce'], "remove", 1) 
		Player.Functions.RemoveItem('ham', 1)
		Player.Functions.RemoveItem('lettuce', 1)
	elseif ItemMake == "cheeseburger" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['meat'], "remove", 1) 
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cheddar'], "remove", 1) 
		Player.Functions.RemoveItem('meat', 1)
		Player.Functions.RemoveItem('cheddar', 1)
	elseif ItemMake == "cheesesandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cheddar'], "remove", 1) 
		Player.Functions.RemoveItem('cheddar', 1)
	elseif ItemMake == "eggsandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['jimeggs'], "remove", 1) 
		Player.Functions.RemoveItem('jimeggs', 1)
	elseif ItemMake == "grilledwrap" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['chickenbreast'], "remove", 1) 
		Player.Functions.RemoveItem('chickenbreast', 1)
	elseif ItemMake == "hamburger" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['meat'], "remove", 1) 
		Player.Functions.RemoveItem('meat', 1)
	elseif ItemMake == "hamcheesesandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ham'], "remove", 1) 
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cheddar'], "remove", 1) 
		Player.Functions.RemoveItem('ham', 1)
		Player.Functions.RemoveItem('cheddar', 1)
	elseif ItemMake == "hamsandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ham'], "remove", 1) 
		Player.Functions.RemoveItem('ham', 1)	
	elseif ItemMake == "ranchwrap" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['chickenbreast'], "remove", 1) 
		Player.Functions.RemoveItem('chickenbreast', 1)	
	elseif ItemMake == "sausageeggs" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['jimsausages'], "remove", 1) 
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['jimeggs'], "remove", 1) 
		Player.Functions.RemoveItem('jimsausages', 1)
		Player.Functions.RemoveItem('jimeggs', 1)	
	elseif ItemMake == "steakburger" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['meat'], "remove", 1) 
		Player.Functions.RemoveItem('meat', 1)	
	elseif ItemMake == "toastbacon" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ham'], "remove", 1) 
		Player.Functions.RemoveItem('ham', 1)	
	elseif ItemMake == "tunasandwich" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['fish'], "remove", 1) 
		Player.Functions.RemoveItem('fish', 1)	
	elseif ItemMake == "veggiewrap" then
	    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['lettuce'], "remove", 1) 
		Player.Functions.RemoveItem('lettuce', 1)	
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, 1, false, {["quality"] = nil})
	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[ItemMake], "add", 1) 
end)

---ITEM REQUIREMENT CHECKS
--Food
QBCore.Functions.CreateCallback('qb-popsdiner:get:baconeggs', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('ham') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('jimeggs') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:bltsandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('ham') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('lettuce') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:cheeseburger', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('meat') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('cheddar') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:cheesesandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('cheddar') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:eggsandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('jimeggs') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:grilledwrap', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('chickenbreast') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:hamburger', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('meat') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('lettuce') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:hamcheesesandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('ham') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('cheddar') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:hamsandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('ham') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:ranchwrap', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('chickenbreast') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:sausageeggs', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('jimsausages') ~= nil and QBCore.Functions.GetPlayer(source).Functions.GetItemByName('jimeggs') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:steakburger', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('meat') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:toastbacon', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('ham') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:tunasandwich', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('fish') ~= nil then cb(true) else cb(false) end end)
QBCore.Functions.CreateCallback('qb-popsdiner:get:veggiewrap', function(source, cb) if QBCore.Functions.GetPlayer(source).Functions.GetItemByName('lettuce') ~= nil then cb(true) else cb(false) end end)

-- // Register \\ 

RegisterServerEvent('qb-popsdiner:Tickets:Give')
AddEventHandler('qb-popsdiner:Tickets:Give', function(amount)
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then
            if Player.PlayerData.job.name == 'popsdiner' and Player.PlayerData.job.onduty then
				if amount >= Config.MinAmountforTicket then
					Player.Functions.AddItem('burger-ticket', 1, false, {["quality"] = nil})
					TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, 'Pop\'s Diner receipt received', 'success')
					TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items['burger-ticket'], "add", 1) 
				elseif amount < Config.MinAmountforTicket then
					TriggerClientEvent("QBCore:Notify", Player.PlayerData.source, "Amount too low, didn't receive a receipt", "error")
				end
			end
        end
    end
end)

RegisterServerEvent('qb-popsdiner:Tickets:Sell')
AddEventHandler('qb-popsdiner:Tickets:Sell', function()
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName("burger-ticket") == nil then TriggerClientEvent('QBCore:Notify', source, "No tickets to trade", 'error') return
	else
		tickets = Player.Functions.GetItemByName("burger-ticket").amount
		Player.Functions.RemoveItem('burger-ticket', tickets)
		Player.Functions.AddMoney('bank', (tickets * Config.PayPerTicket), 'popsdiner-payment')
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['burger-ticket'], "remove", tickets)
		TriggerClientEvent('QBCore:Notify', source, "Tickets: "..tickets.." Total: $"..pay, 'success')
	end
end)

RegisterServerEvent("qb-popsdiner:server:Charge", function(citizen, price, billtype)
    local biller = QBCore.Functions.GetPlayer(source)
    local billed = QBCore.Functions.GetPlayer(tonumber(citizen))
    local amount = tonumber(price)
	local billtype = string.lower(tostring(billtype))

	if billed ~= nil then
		if billtype == "cash" then balance = billed.Functions.GetMoney(billtype)
			--if source == tonumber(citizen) then TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error') return end
			if balance >= amount then billed.Functions.RemoveMoney('cash', amount) TriggerEvent("qb-bossmenu:server:addAccountMoney", tostring(biller.PlayerData.job.name), amount)	TriggerEvent('qb-popsdiner:Tickets:Give', amount)
			elseif balance < amount then
				TriggerClientEvent("QBCore:Notify", source, "Customer doesn't have enough cash to pay", "error")
				TriggerClientEvent("QBCore:Notify", tonumber(citizen), "You don't have enough cash to pay", "error")
			end
		elseif billtype == "card" then	
			--if biller.PlayerData.citizenid == billed.PlayerData.citizenid then TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error') return end
			if amount and amount > 0 then
				MySQL.Async.insert(
					'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
					{billed.PlayerData.citizenid, amount, biller.PlayerData.job.name,
					 biller.PlayerData.charinfo.firstname, biller.PlayerData.citizenid})
				TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
				TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
				TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
			else TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')	end
		end
	else TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error') end
end)

QBCore.Functions.CreateCallback('qb-popsdiner:server:GetCurrentPlayers', function(source, cb)
	local onlineList = {}
	local SPlayer = QBCore.Functions.GetPlayer(source)
	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		local Player = QBCore.Functions.GetPlayer(v)
		if Player ~= nil then
			local dist = #(vector3(Player.PlayerData.position.x, Player.PlayerData.position.y, Player.PlayerData.position.z) - vector3(SPlayer.PlayerData.position.x, SPlayer.PlayerData.position.y, SPlayer.PlayerData.position.z))
			if dist < Config.ClockOutDist then onlineList[#onlineList+1] = { value = tonumber(v), text = "["..v.."] - "..Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname } end
		end
	end
	cb(onlineList)
end)
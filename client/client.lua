local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}
local onDuty = false

local function installCheck()
	local items = {
				"baconeggs", "bltsandwich", "cheeseburger", "cheesesandwich", "eggsandwich", "grilledwrap", 
				"hamburger", "hamcheesesandwich", "hamsandwich", "ranchwrap", "sausageeggs", "steakburger", 
				"toastbacon", "tunasandwich", "veggiewrap", "carrotcake", "cheesecake", "chocpudding", 
				"jelly", "popdonut", "popicecream", "crisps", "chickenbreast", "jimsausages", "jimeggs", "ham", 
				"fish", "meat", "chocolate", "lettuce", "cheddar", "sprunk", "sprunklight", "ecola", "ecolalight"
			}
	for k, v in pairs(items) do if QBCore.Shared.Items[v] == nil then print("Missing Item from QBCore.Shared.Items: '"..v.."'") end end
	if QBCore.Shared.Jobs["popsdiner"] == nil then print("Error: Job role not found - 'popsdiner'") end
	if Config.Debug then print((#Config.Chairs).." Total seating locations") print((#items).." Items required") end
end

local function jobCheck()
	canDo = true
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') canDo = false end
	return canDo
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
		installCheck()
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then if PlayerData.job.name == "popsdiner" then TriggerServerEvent("QBCore:ToggleDuty") end end
    end)
end)
RegisterNetEvent('QBCore:Client:OnJobUpdate') AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo) PlayerJob = JobInfo onDuty = PlayerJob.onduty end) 
RegisterNetEvent('QBCore:Client:SetDuty') AddEventHandler('QBCore:Client:SetDuty', function(duty) onDuty = duty end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
		installCheck()
		QBCore.Functions.GetPlayerData(function(PlayerData)
			PlayerJob = PlayerData.job
			if PlayerData.job.name == "popsdiner" then onDuty = PlayerJob.onduty end 
		end)
    end
end)

CreateThread(function()
	local bossroles = {}
	for k, v in pairs(QBCore.Shared.Jobs["popsdiner"].grades) do
		if QBCore.Shared.Jobs["popsdiner"].grades[k].isboss == true then
			if bossroles["popsdiner"] ~= nil then
				if bossroles["popsdiner"] > tonumber(k) then bossroles["popsdiner"] = tonumber(k) end
			else bossroles["popsdiner"] = tonumber(k)	end
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			JobLocation = PolyZone:Create(Config.Locations[k].zones, { name = Config.Locations[k].label, debugPoly = Config.Debug })
			JobLocation:onPlayerInOut(function(isPointInside) if not isPointInside and onDuty and PlayerJob.name == "popsdiner" then TriggerServerEvent("QBCore:ToggleDuty") end end)	
		end
	end
	for k, v in pairs(Config.Locations) do
		if Config.Locations[k].zoneEnable then
			blip = AddBlipForCoord(Config.Locations[k].blip)
			SetBlipAsShortRange(blip, true)
			SetBlipSprite(blip, 267)
			SetBlipColour(blip, Config.Locations[k].blipcolor)
			SetBlipScale(blip, 0.6)
			SetBlipDisplay(blip, 6)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString("Pops Diner")
			EndTextCommandSetBlipName(blip)
		end
	end
	if atm == nil then
		RequestModel(GetHashKey("prop_atm_01"))
		while not HasModelLoaded(GetHashKey("prop_atm_01")) do Citizen.Wait(1) end
		atm = CreateObject(GetHashKey("prop_atm_01"),1580.31, 6455.34, 25.32-1.03,false,false,false)
		SetEntityHeading(atm,GetEntityHeading(atm)-25)
		FreezeEntityPosition(atm, true)
	end
	
	if board == nil then
		RequestModel(GetHashKey("bkr_prop_fakeid_clipboard_01a"))
		while not HasModelLoaded(GetHashKey("bkr_prop_fakeid_clipboard_01a")) do Citizen.Wait(1) end
		board = CreateObject(GetHashKey("bkr_prop_fakeid_clipboard_01a"),1594.12, 6456.05, 26.01+0.07,false,false,false)
		SetEntityHeading(board,GetEntityHeading(board)-46)
		FreezeEntityPosition(board, true)
	end	

	CreateModelHide(vector3(1593.85, 6455.37, 26.01), 1.5, 1251246798, true)
	exports['qb-target']:AddBoxZone("PopFridge", vector3(1586.92, 6456.87, 26.01), 0.6, 2.0, { name="PopFridge", heading = 335.0, debugPoly=Config.Debug, minZ = 24.96, maxZ = 25.96, }, 
		{ options = { {  event = "qb-popsdiner:Shop", icon = "fas fa-archive", label = "Open Food Fridge", job = "popsdiner" }, },
		  distance = 2.0
	})
	
	exports['qb-target']:AddBoxZone("PopCounter", vector3(1586.69, 6457.08, 26.01), 0.4, 0.6, { name="PopCounter", heading = 331.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 26.51, }, 
		{ options = { { event = "qb-popsdiner:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter1" }, },
		  distance = 2.0
	})
	exports['qb-target']:AddBoxZone("PopCounter2", vector3(1590.37, 6455.31, 26.01), 0.4, 0.6, { name="PopCounter2", heading = 336.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 26.51, }, 
		{ options = { { event = "qb-popsdiner:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter2" }, },
		  distance = 2.0
	})
	exports['qb-target']:AddBoxZone("PopCounter3", vector3(1593.6, 6453.82, 26.01), 0.4, 0.6, { name="PopCounter3", heading = 336.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 26.51, }, 
		{ options = { { event = "qb-popsdiner:Stash", icon = "fas fa-hamburger", label = "Open Counter", stash = "Counter3" }, },
		  distance = 2.0
	})

	exports['qb-target']:AddBoxZone("PopReceipt", vector3(1589.14, 6458.26, 26.01), 0.6, 0.6, { name="PopReceipt", heading = 335.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 26.81, }, 
		{ options = { { event = "qb-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "popsdiner" } },
		  distance = 2.0
	})
	exports['qb-target']:AddBoxZone("PopReceipt2", vector3(1595.32, 6455.37, 26.01), 0.6, 0.6, { name="PopReceipt2", heading = 50.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 26.81, }, 
		{ options = { { event = "qb-payments:client:Charge", icon = "fas fa-credit-card", label = "Charge Customer", job = "popsdiner" } },
		  distance = 2.0
	})

	exports['qb-target']:AddBoxZone("PopCoffee", vector3(1592.6, 6456.8, 26.01), 0.6, 1.4, { name="PopCoffee", heading = 335.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 27.01, }, 
		{ options = { { event = "qb-popsdiner:JustGive", icon = "fas fa-mug-hot", label = "Pour Coffee", job = "popsdiner", id = "coffee"}, },
		  distance = 2.0
	})
	
	exports['qb-target']:AddBoxZone("PopClockin", vector3(1594.12, 6456.05, 26.01), 0.6, 0.6, { name="PopClockin", heading = 325.0, debugPoly=Config.Debug, minZ = 25.81, maxZ = 26.61, }, 
		{ options = { { type = "server", event = "QBCore:ToggleDuty", icon = "fas fa-user-check", label = "Toggle Duty", job = "popsdiner" }, },
		  distance = 2.0
	})
	exports['qb-target']:AddBoxZone("PopOven", vector3(1587.94, 6459.02, 26.01), 0.6, 1.4, { name="PopOven", heading = 335.0, debugPoly=Config.Debug, minZ = 25.81, maxZ = 26.61, }, 
		{ options = { { event = "qb-popsdiner:Oven:Check", icon = "fas fa-temperature-high", label = "Use Griddle", job = "popsdiner" }, },
		  distance = 2.0
	})
	exports['qb-target']:AddBoxZone("PopBoard", vector3(1586.95, 6459.29, 26.01), 0.4, 0.6, { name="PopBoard", heading = 335.0, debugPoly=Config.Debug, minZ = 25.81, maxZ = 26.61, }, 
		{ options = { { event = "qb-popsdiner:Board:Check", icon = "fas fa-utensils", label = "Use Chopping Board", job = "popsdiner" }, },
		  distance = 2.0
	})	
	exports['qb-target']:AddBoxZone("PopDrinks", vector3(1586.03, 6459.62, 26.01), 0.6, 1.1, { name="PopDrinks", heading = 335.0, debugPoly=Config.Debug, minZ = 26.01, maxZ = 27.01, }, 
		{ options = { { event = "qb-popsdiner:Drinks", icon = "fas fa-beer", label = "Use Drinks Machine", job = "popsdiner" }, },
		  distance = 2.0
	})
end)

RegisterNetEvent('qb-popsdiner:MakeItem', function(data)
	local items = { "baconeggs", "bltsandwich", "cheeseburger", "cheesesandwich", "eggsandwich", "grilledwrap", "hamburger", "hamcheesesandwich", "hamsandwich", "ranchwrap", "sausageeggs", "steakburger", "toastbacon", "tunasandwich", "veggiewrap" }
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') else
		for k,v in pairs(items) do 
			if data.item == v then QBCore.Functions.TriggerCallback('qb-popsdiner:get:'..data.item, function(amount) 
				if not amount then TriggerEvent('QBCore:Notify', "You don't have the correct ingredients", 'error') else FoodProgress(data.item) end end)
			end
		end
	end
end)

RegisterNetEvent('qb-popsdiner:Stash', function(data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "popsdiner_"..data.stash)
    TriggerEvent("inventory:client:SetCurrentStash", "popsdiner_"..data.stash)
end)

RegisterNetEvent('qb-popsdiner:Shop', function()
	if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') else 
		TriggerServerEvent("inventory:server:OpenInventory", "shop", "popsdiner", Config.FoodItems)
	end
end)

function FoodProgress(ItemMake)
	if ItemMake == "baconeggs" or ItemMake == "bltsandwich" or ItemMake == "cheeseburger" or ItemMake == "cheesesandwich" or ItemMake == "eggsandwich" or ItemMake == "grilledwrap" or ItemMake == "hamburger" or ItemMake == "hamcheesesandwich" 
	or ItemMake == "hamsandwich" or ItemMake == "ranchwrap" or ItemMake == "sausageeggs" or ItemMake == "steakburger" or ItemMake == "toastbacon" or ItemMake == "tunasandwich" or ItemMake == "veggiewrap" then
		bartext = "Cooking "..QBCore.Shared.Items[ItemMake].label
		bartime = 5000
        animDictNow = "amb@prop_human_bbq@male@base"
        animNow = "base"
	elseif ItemMake == "coffee" or ItemMake == "ecola" or ItemMake == "ecolalight" or ItemMake == "sprunk" or ItemMake == "sprunklight" then
		bartext = "Pouring "..QBCore.Shared.Items[ItemMake].label
		bartime = 3000
		animDictNow = "mp_ped_interaction"
		animNow = "handshake_guy_a"	
	end
	QBCore.Functions.Progressbar('making_food', bartext, bartime, false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, 
		{ animDict = animDictNow, anim = animNow, flags = 8, }, {}, {}, function()  
		TriggerServerEvent('qb-popsdiner:GetFood', ItemMake)
		StopAnimTask(GetPlayerPed(-1), animDictNow, animNow, 1.0)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
		TriggerEvent('QBCore:Notify', "Cancelled!", 'error')
	end)
end

RegisterNetEvent('qb-popsdiner:Drinks', function()
	exports['qb-menu']:openMenu({
		{ header = "Drinks Dispenser", isMenuHeader = true }, 
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["ecola"].image.." width=35px> "..QBCore.Shared.Items["ecola"].label, params = { event = "qb-popsdiner:JustGive", args = { id = 'ecola' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["ecolalight"].image.." width=35px> "..QBCore.Shared.Items["ecolalight"].label, params = { event = "qb-popsdiner:JustGive", args = { id = 'ecolalight' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["sprunk"].image.." width=35px> "..QBCore.Shared.Items["sprunk"].label, params = { event = "qb-popsdiner:JustGive", args = { id = 'sprunk' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["sprunklight"].image.." width=35px> "..QBCore.Shared.Items["sprunklight"].label, params = { event = "qb-popsdiner:JustGive", args = { id = 'sprunklight' } } },
	})
end)

--Griddle oven
RegisterNetEvent('qb-popsdiner:Oven:Check', function()
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:baconeggs', function(amount) if amount then baconeggs = "✔" else baconeggs = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:cheeseburger', function(amount) if amount then cheeseburger = "✔" else cheeseburger = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:hamburger', function(amount) if amount then hamburger = "✔" else hamburger = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:sausageeggs', function(amount) if amount then sausageeggs = "✔" else sausageeggs = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:steakburger', function(amount) if amount then steakburger = "✔" else steakburger = "" end end)
	Wait(100)
	TriggerEvent('qb-popsdiner:Oven')
end)
RegisterNetEvent('qb-popsdiner:Oven', function()
	exports['qb-menu']:openMenu({
		{ header = "Griddle Menu", isMenuHeader = true }, 
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["baconeggs"].image.." width=35px> "..QBCore.Shared.Items["baconeggs"].label.." "..baconeggs, txt = "- "..QBCore.Shared.Items["ham"].label.."<br>- "..QBCore.Shared.Items["jimeggs"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'baconeggs' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["cheeseburger"].image.." width=35px> "..QBCore.Shared.Items["cheeseburger"].label.." "..cheeseburger, txt = "- "..QBCore.Shared.Items["meat"].label.."<br>- "..QBCore.Shared.Items["cheddar"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'cheeseburger' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["hamburger"].image.." width=35px> "..QBCore.Shared.Items["hamburger"].label.." "..hamburger, txt = "- "..QBCore.Shared.Items["meat"].label.."<br>- "..QBCore.Shared.Items["lettuce"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'hamburger' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["sausageeggs"].image.." width=35px> "..QBCore.Shared.Items["sausageeggs"].label.." "..sausageeggs, txt = "- "..QBCore.Shared.Items["jimsausages"].label.."<br>- "..QBCore.Shared.Items["jimeggs"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'sausageeggs' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["steakburger"].image.." width=35px> "..QBCore.Shared.Items["steakburger"].label.." "..steakburger, txt = "- "..QBCore.Shared.Items["meat"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'steakburger' } } },
	})
end)

--Chopping board, sandwiches
RegisterNetEvent('qb-popsdiner:Board:Check', function()
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:bltsandwich', function(amount) if amount then bltsandwich = "✔" else bltsandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:cheesesandwich', function(amount) if amount then cheesesandwich = "✔" else cheesesandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:eggsandwich', function(amount) if amount then eggsandwich = "✔" else eggsandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:grilledwrap', function(amount) if amount then grilledwrap = "✔" else grilledwrap = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:hamcheesesandwich', function(amount) if amount then hamcheesesandwich = "✔" else hamcheesesandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:hamsandwich', function(amount) if amount then hamsandwich = "✔" else hamsandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:ranchwrap', function(amount) if amount then ranchwrap = "✔" else ranchwrap = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:toastbacon', function(amount) if amount then toastbacon = "✔" else toastbacon = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:tunasandwich', function(amount) if amount then tunasandwich = "✔" else tunasandwich = "" end end)
	QBCore.Functions.TriggerCallback('qb-popsdiner:get:veggiewrap', function(amount) if amount then veggiewrap = "✔" else veggiewrap = "" end end)
	Wait(300)
	TriggerEvent('qb-popsdiner:Board')
end)
RegisterNetEvent('qb-popsdiner:Board', function()
	exports['qb-menu']:openMenu({
		{ header = "Oven Menu", isMenuHeader = true },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["bltsandwich"].image.." width=35px> "..QBCore.Shared.Items["bltsandwich"].label.." "..bltsandwich, txt = "- "..QBCore.Shared.Items["ham"].label.."<br>- "..QBCore.Shared.Items["lettuce"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'bltsandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["cheesesandwich"].image.." width=35px> "..QBCore.Shared.Items["cheesesandwich"].label.." "..cheesesandwich, txt = "- "..QBCore.Shared.Items["cheddar"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'cheesesandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["eggsandwich"].image.." width=35px> "..QBCore.Shared.Items["eggsandwich"].label.." "..eggsandwich, txt = "- "..QBCore.Shared.Items["jimeggs"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'eggsandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["grilledwrap"].image.." width=35px> "..QBCore.Shared.Items["grilledwrap"].label.." "..grilledwrap, txt = "- "..QBCore.Shared.Items["chickenbreast"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'grilledwrap' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["hamcheesesandwich"].image.." width=35px> "..QBCore.Shared.Items["hamcheesesandwich"].label.." "..hamcheesesandwich, txt = "- "..QBCore.Shared.Items["ham"].label.."<br>- "..QBCore.Shared.Items["cheddar"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'hamcheesesandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["hamsandwich"].image.." width=35px> "..QBCore.Shared.Items["hamsandwich"].label.." "..hamsandwich, txt = "- "..QBCore.Shared.Items["ham"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'hamsandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["ranchwrap"].image.." width=35px> "..QBCore.Shared.Items["ranchwrap"].label.." "..ranchwrap, txt = "- "..QBCore.Shared.Items["chickenbreast"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'ranchwrap' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["toastbacon"].image.." width=35px> "..QBCore.Shared.Items["toastbacon"].label.." "..toastbacon, txt = "- "..QBCore.Shared.Items["ham"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'toastbacon' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["tunasandwich"].image.." width=35px> "..QBCore.Shared.Items["tunasandwich"].label.." "..tunasandwich, txt = "- "..QBCore.Shared.Items["fish"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'tunasandwich' } } },
		{ header = "<img src=nui://"..Config.link..QBCore.Shared.Items["veggiewrap"].image.." width=35px> "..QBCore.Shared.Items["veggiewrap"].label.." "..veggiewrap, txt = "- "..QBCore.Shared.Items["lettuce"].label, params = { event = "qb-popsdiner:MakeItem", args = { item = 'veggiewrap' } } },
	})
end)

RegisterNetEvent('qb-popsdiner:JustGive', function(data) if not onDuty then TriggerEvent('QBCore:Notify', "Not clocked in!", 'error') else FoodProgress(data.id) end end)

RegisterNetEvent('qb-popsdiner:client:Drink', function(itemName)
	if itemName == "sprunk" or itemName == "sprunklight" then TriggerEvent('animations:client:EmoteCommandStart', {"sprunk"})
	elseif itemName == "ecola" or itemName == "ecolalight" then TriggerEvent('animations:client:EmoteCommandStart', {"ecola"})
	elseif itemName == "coffee" then TriggerEvent('animations:client:EmoteCommandStart', {"coffee"}) end
	QBCore.Functions.Progressbar("drink_something", "Drinking "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + QBCore.Shared.Items[itemName].thirst)
	end)
end)

RegisterNetEvent('qb-popsdiner:client:Eat', function(itemName)
	if itemName == "crisps" then TriggerEvent('animations:client:EmoteCommandStart', {"crisps"})
	elseif itemName == "bltsandwich" or itemName == "cheesesandwich" or itemName == "eggsandwich" or itemName == "grilledwrap" or itemName == "hamcheesesandwich" or itemName == "hamsandwich"
	or itemName == "ranchwrap" or itemName == "tunasandwich" or itemName == "veggiewrap" then TriggerEvent('animations:client:EmoteCommandStart', {"sandwich"})
	elseif itemName == "popdonut" then TriggerEvent('animations:client:EmoteCommandStart', {"donut"})
	else TriggerEvent('animations:client:EmoteCommandStart', {"burger"}) end
    QBCore.Functions.Progressbar("eat_something", "Eating "..QBCore.Shared.Items[itemName].label.."..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove", 1)
		TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + QBCore.Shared.Items[itemName].hunger)
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

AddEventHandler('onResourceStop', function(resource) 
	if resource == GetCurrentResourceName() then
		DeleteEntity(board)
		DeleteEntity(atm)
		exports['qb-target']:RemoveZone("PopFridge") 
		exports['qb-target']:RemoveZone("PopCounter") 
		exports['qb-target']:RemoveZone("PopCounter2") 
		exports['qb-target']:RemoveZone("PopCounter3") 
		exports['qb-target']:RemoveZone("PopReceipt") 
		exports['qb-target']:RemoveZone("PopReceipt2") 
		exports['qb-target']:RemoveZone("PopCoffee") 
		exports['qb-target']:RemoveZone("PopClockin") 
		exports['qb-target']:RemoveZone("PopOven") 
		exports['qb-target']:RemoveZone("PopBoard") 
		exports['qb-target']:RemoveZone("PopDrinks")
	end
end)

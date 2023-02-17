local QBCore = exports['qb-core']:GetCoreObject()

local popseat = 0
local sitting = false

CreateThread(function()
	for k, v in pairs(Config.Chairs) do
		exports['qb-target']:AddBoxZone("PopChair"..k, v.location, v.width, v.height, { name="PopChair"..k, heading = v.heading, debugPoly=Config.Debug, minZ = v.minZ, maxZ = v.maxZ, }, 
			{ options = { { event = "qb-popsdiner:Chair", icon = "fas fa-chair", label = "Sit Down", loc = v.location, head = v.heading, seat = v.seat }, },
			  distance = v.distance
		})
	end
end)

RegisterNetEvent('qb-popsdiner:Chair', function(data)
	local canSit = true
	local sitting = false
	for k, v in pairs(QBCore.Functions.GetPlayersFromCoords(data.loc, 0.6)) do
		local dist = #(GetEntityCoords(GetPlayerPed(v)) - data.loc)
		if dist <= 0.4 then TriggerEvent("QBCore:Notify", "Someone is already sitting there..") canSit = false end
	end
	if canSit then
		TaskStartScenarioAtPosition(PlayerPedId(), "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", data.loc.x, data.loc.y, data.loc.z-0.5, data.head, 0, 1, true)
		popseat = data.seat
		sitting = true
	end
	while sitting do
		local ped = PlayerPedId()
		if sitting then 
			if IsControlJustReleased(0, 202) and IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then
				sitting = false
				ClearPedTasks(ped)

				if popseat == 1 then SetEntityCoords(ped, vector3(1593.93, 6451.63, 26.01-0.5)) end
				if popseat == 2 then SetEntityCoords(ped, vector3(1592.65, 6452.07, 26.01-0.5)) end
				if popseat == 3 then SetEntityCoords(ped, vector3(1592.09, 6452.27, 26.01-0.5)) end
				if popseat == 4 then SetEntityCoords(ped, vector3(1590.93, 6452.8, 26.01-0.5)) end
				if popseat == 5 then SetEntityCoords(ped, vector3(1590.28, 6453.06, 26.01-0.5)) end
				if popseat == 6 then SetEntityCoords(ped, vector3(1589.06, 6453.71, 26.01-0.5)) end
				if popseat == 7 then SetEntityCoords(ped, vector3(1588.43, 6454.06, 26.01-0.5)) end
				if popseat == 8 then SetEntityCoords(ped, vector3(1587.29, 6454.5, 26.01-0.5)) end
				if popseat == 9 then SetEntityCoords(ped, vector3(1586.58, 6454.88, 26.01-0.5)) end
				if popseat == 10 then SetEntityCoords(ped, vector3(1585.42, 6455.34, 26.01-0.5)) end
				if popseat == 11 then SetEntityCoords(ped, vector3(1584.83, 6455.58, 26.01-0.5)) end
				if popseat == 12 then SetEntityCoords(ped, vector3(1583.71, 6456.25, 26.01-0.5)) end
				if popseat == 13 then SetEntityCoords(ped, vector3(1582.9, 6456.53, 26.01-0.5)) end
				if popseat == 14 then SetEntityCoords(ped, vector3(1581.86, 6457.11, 26.01-0.5)) end
				
				if popseat == 15 then SetEntityCoords(ped, vector3(1582.95, 6459.58, 26.01-0.5)) end
				if popseat == 16 then SetEntityCoords(ped, vector3(1583.37, 6458.66, 26.01-0.5)) end
				if popseat == 17 then SetEntityCoords(ped, vector3(1583.76, 6457.69, 26.01-0.5)) end
				if popseat == 18 then SetEntityCoords(ped, vector3(1584.61, 6456.82, 26.01-0.5)) end
				if popseat == 19 then SetEntityCoords(ped, vector3(1585.66, 6456.33, 26.01-0.5)) end
				if popseat == 20 then SetEntityCoords(ped, vector3(1586.59, 6455.9, 26.01-0.5)) end
				if popseat == 21 then SetEntityCoords(ped, vector3(1589.88, 6454.4, 26.01-0.5)) end
				if popseat == 22 then SetEntityCoords(ped, vector3(1590.83, 6453.95, 26.01-0.5)) end
				if popseat == 23 then SetEntityCoords(ped, vector3(1592.58, 6453.13, 26.01-0.5)) end
				if popseat == 24 then SetEntityCoords(ped, vector3(1593.69, 6452.59, 26.01-0.5)) end
				if popseat == 25 then SetEntityCoords(ped, vector3(1594.73, 6452.12, 26.01-0.5)) end
				
				popseat = 0
			end
		end
		Wait(5) if not IsPedUsingScenario(ped, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER") then sitting = false end
	end
end)

Config.Chairs = {	
	--Booth 1
	{ location = vector3(1593.25, 6450.03, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.5, seat = 1 },
	{ location = vector3(1593.57, 6450.74, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 1 },

	{ location = vector3(1591.93, 6450.64, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.5, seat = 2 },
	{ location = vector3(1592.28, 6451.36, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 2 },
	--Booth 2
	{ location = vector3(1591.42, 6450.89, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 3 },
	{ location = vector3(1591.75, 6451.59, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 3 },

	{ location = vector3(1590.15, 6451.5, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 4 },
	{ location = vector3(1590.47, 6452.21, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 4 },
	--Booth 3
	{ location = vector3(1589.61, 6451.71, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 5 },
	{ location = vector3(1589.93, 6452.44, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 5 },

	{ location = vector3(1588.32, 6452.35, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 6 },
	{ location = vector3(1588.67, 6453.08, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 6 },
	--Booth 4
	{ location = vector3(1587.82, 6452.59, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 7 },
	{ location = vector3(1588.14, 6453.29, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 7 },

	{ location = vector3(1586.52, 6453.2, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 8 },
	{ location = vector3(1586.83, 6453.91, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 8 },
	--Booth 5
	{ location = vector3(1586.0, 6453.43, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 9 },
	{ location = vector3(1586.33, 6454.15, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 9 },

	{ location = vector3(1584.7, 6454.06, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 10 },
	{ location = vector3(1585.03, 6454.77, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 10 },
	--Booth 6
	{ location = vector3(1584.17, 6454.27, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 11 },
	{ location = vector3(1584.51, 6454.99, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 11 },

	{ location = vector3(1582.87, 6454.9, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 12 },
	{ location = vector3(1583.22, 6455.63, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 12 },
	--Booth 7
	{ location = vector3(1582.38, 6455.12, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 13 },
	{ location = vector3(1582.73, 6455.85, 26.01), heading = 65.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 13 },

	{ location = vector3(1581.06, 6455.75, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 2.2, seat = 14 },
	{ location = vector3(1581.39, 6456.45, 26.01), heading = 245.0, width = 0.6, height = 0.6, minZ=24.66, maxZ=26.06, distance = 1.7, seat = 14 },

	--STOOLS
	{ location = vector3(1583.35, 6459.67, 26.01+0.36), heading = 284.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 15 },
	{ location = vector3(1583.67, 6458.75, 26.01+0.36), heading = 288.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 16 },
	{ location = vector3(1584.02, 6457.82, 26.01+0.36), heading = 303.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 17 },
	{ location = vector3(1584.8, 6457.06, 26.01+0.36), heading = 319.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 18 },
	{ location = vector3(1585.75, 6456.6, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 19 },
	{ location = vector3(1586.67, 6456.17, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 20 },
	{ location = vector3(1589.98, 6454.62, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 21 },
	{ location = vector3(1590.89, 6454.19, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 22 },
	{ location = vector3(1592.75, 6453.48, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 23 },
	{ location = vector3(1593.77, 6452.84, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 24 },
	{ location = vector3(1594.82, 6452.35, 26.01+0.36), heading = 336.0, width = 0.6, height = 0.6, minZ=24.66+0.36, maxZ=26.06+0.36, distance = 1.7, seat = 25 },
	
}

AddEventHandler('onResourceStop', function(r) 
	if r == GetCurrentResourceName() then for k, v in pairs(Config.Chairs) do exports['qb-target']:RemoveZone("PopChair"..k) end end 
end)
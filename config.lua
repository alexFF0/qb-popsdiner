Config = {}

Config.Debug = false -- false to remove green boxes

Config.link = "qb-inventory/html/images/" --Set this to the image directory of your inventory script

Config.Locations = {
    [1] = {
		zoneEnable = true,
        label = "popsdiner", -- Set this to the required job
        zones = {
			vector2(1558.0170898438, 6442.4106445312),
			vector2(1601.52734375, 6424.2348632812),
			vector2(1610.9509277344, 6449.2001953125),
			vector2(1613.7552490234, 6464.6137695312),
			vector2(1575.8428955078, 6482.0229492188)
        },
		blip = vector3(1583.98, 6449.49, 25.18),
		blipcolor = 48,
    },
}

Config.FoodItems = {
    label = "Food Fridge Store",
    slots = 18,
    items = {
        [1] = { name = "jimsausages", price = 0, amount = 50, info = {}, type = "item", slot = 1, },
        [2] = { name = "jimeggs", price = 0, amount = 50, info = {}, type = "item", slot = 2, },
        [3] = { name = "meat", price = 0, amount = 50, info = {}, type = "item", slot = 3, },
        [4] = { name = "cheddar", price = 0, amount = 50, info = {}, type = "item", slot = 4, },
        [5] = { name = "chickenbreast", price = 0, amount = 50, info = {}, type = "item", slot = 5, },
        [6] = { name = "ham", price = 0, amount = 50, info = {}, type = "item", slot = 6, },
        [7] = { name = "lettuce", price = 0, amount = 50, info = {}, type = "item", slot = 7, },
        [8] = { name = "fish", price = 0, amount = 50, info = {}, type = "item", slot = 8, },
		
		[9] = { name = "carrotcake", price = 0, amount = 50, info = {}, type = "item", slot = 9, },
        [10] = { name = "cheesecake", price = 0, amount = 50, info = {}, type = "item", slot = 10, },
        [11] = { name = "jelly", price = 0, amount = 50, info = {}, type = "item", slot = 11, },
        [12] = { name = "chocpudding", price = 0, amount = 50, info = {}, type = "item", slot = 12, },
        [13] = { name = "popdonut", price = 0, amount = 50, info = {}, type = "item", slot = 13, },
        [14] = { name = "popicecream", price = 0, amount = 50, info = {}, type = "item", slot = 14, },
        [15] = { name = "chocolate", price = 0, amount = 50, info = {}, type = "item", slot = 15, },
        [16] = { name = "crisps", price = 0, amount = 50, info = {}, type = "item", slot = 16, }
    }
}
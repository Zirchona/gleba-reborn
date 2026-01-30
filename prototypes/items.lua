
-- Artificial Tree Soil
local treeSoilName = "gleba-reborn-artificial-tree-soil"

local jellynutTile = data.raw.tile["artificial-jellynut-soil"]

local treeSoilTile = table.deepcopy(data.raw.tile["grass-1"])
treeSoilTile.name = treeSoilName
treeSoilTile.minable = jellynutTile.minable
treeSoilTile.minable.result = treeSoilName
treeSoilTile.mined_sound = jellynutTile.mined_sound
treeSoilTile.map_color={52, 72, 10}
treeSoilTile.is_foundation = true

local treeSoilItem = table.deepcopy(data.raw.item["artificial-jellynut-soil"])
treeSoilItem.name = treeSoilName
treeSoilItem.place_as_tile.result = treeSoilName
treeSoilItem.place_as_tile.condition_size = 1
treeSoilItem.place_as_tile.tile_condition = {
	"dirt-1",
	"sand-1",
	"sand-2",
	"sand-3",
	"red-desert-1",
	"red-desert-2",
	"red-desert-3"
}
treeSoilItem.place_as_tile.condition.layers = {}
treeSoilItem.icon = "__gleba-reborn__/graphics/icons/artificial-tree-soil.png"
treeSoilItem.order = "c[landfill]-eb[artificial-tree-soil]" -- Display after overgrowth jellynut soil, which has order "c[landfill]-e[overgrowth-jellynut-soil]"

-- Allow trees to be planted on the new soil
table.insert(data.raw.plant["tree-plant"].autoplace.tile_restriction, treeSoilName)
-- Also allow trees to be planted on landfill, because why can't they be to begin with?
table.insert(data.raw.plant["tree-plant"].autoplace.tile_restriction, "landfill")


data:extend {
	treeSoilTile,
	treeSoilItem
}
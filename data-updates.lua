
require("prototypes/recipes")
require("prototypes/items")
require("common")



local jellynut_biome_tiles = {
	"wetland-pink-tentacle",
	"wetland-red-tentacle",
	"wetland-jellynut",
	"lowland-red-vein",
	"lowland-red-vein-2",
	"lowland-red-vein-3",
	"lowland-red-vein-4",
	"lowland-red-vein-dead",
	"lowland-red-infection",
	"lowland-cream-red"
}

local yumako_biome_tiles = {
	"wetland-light-green-slime",
	"wetland-green-slime",
	"wetland-yumako",
	"lowland-olive-blubber",
	"lowland-olive-blubber-2",
	"lowland-olive-blubber-3",
	"lowland-brown-blubber",
	"lowland-pale-green"
}

local all_gleba_tiles = {
	"gleba-deep-lake",
	"highland-dark-rock",
	"highland-dark-rock-2",
	"highland-yellow-rock",
	"lowland-brown-blubber",
	"lowland-cream-cauliflower",
	"lowland-cream-cauliflower-2",
	"lowland-cream-red",
	"lowland-dead-skin",
	"lowland-dead-skin-2",
	"lowland-olive-blubber",
	"lowland-olive-blubber-2",
	"lowland-olive-blubber-3",
	"lowland-pale-green",
	"lowland-red-infection",
	"lowland-red-vein",
	"lowland-red-vein-2",
	"lowland-red-vein-3",
	"lowland-red-vein-4",
	"lowland-red-vein-dead",
	"midland-cracked-lichen",
	"midland-cracked-lichen-dark",
	"midland-cracked-lichen-dull",
	"midland-turquoise-bark",
	"midland-turquoise-bark-2",
	"midland-yellow-crust",
	"midland-yellow-crust-2",
	"midland-yellow-crust-3",
	"midland-yellow-crust-4",
	"natural-jellynut-soil",
	"natural-yumako-soil",
	"pit-rock",
	"wetland-blue-slime",
	"wetland-dead-skin",
	"wetland-green-slime",
	"wetland-jellynut",
	"wetland-light-dead-skin",
	"wetland-light-green-slime",
	"wetland-pink-tentacle",
	"wetland-red-tentacle",
	"wetland-yumako"
}



if settings.startup["gleba-reborn-egg-free-biochamber"].value then
	-- Update biochamber recipe
	update_recipe("biochamber", "nutrients", "yumako-mash", 10)
	update_recipe("biochamber", "pentapod-egg", "jelly", 10)
	
	-- Since biochamber recipe won't require nutrients, we unlock it by crafting yumako mash instead
	local biochamber_tech = data.raw.technology["biochamber"]
	biochamber_tech.research_trigger = {
		count = 1,
		item = "yumako-mash",
		type = "craft-item"
	}
end

if settings.startup["gleba-reborn-advanced-bacteria-recipes"].value then
	-- Add new recipes
	table.insert(data.raw.technology["biochamber"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-iron-bacteria-extrusion" })
	table.insert(data.raw.technology["biochamber"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-copper-bacteria-extrusion" })
	table.insert(data.raw.technology["bioflux-processing"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-circuit-bacteria-extrusion" })
	table.insert(data.raw.technology["bioflux-processing"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-steel-bacteria-extrusion" })
	table.insert(data.raw.technology["bioflux-processing"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-bioexplosives" })
	table.insert(data.raw.technology["steel-plate-productivity"].effects, { change = 0.1, recipe = "gleba-reborn-steel-bacteria-extrusion", type = "change-recipe-productivity" })
	
	-- Add new subgroup to put all the bacteria recipes on their own line in the crafting recipe menu
	data.raw.recipe["iron-bacteria"].subgroup = "gleba-reborn-bacteria-processes"
	data.raw.recipe["copper-bacteria"].subgroup = "gleba-reborn-bacteria-processes"
	data.raw.recipe["iron-bacteria-cultivation"].subgroup = "gleba-reborn-bacteria-processes"
	data.raw.recipe["copper-bacteria-cultivation"].subgroup = "gleba-reborn-bacteria-processes"
	
	-- Move biolubricant recipe from bioflux processing to biochamber, since the recipe doesn't require bioflux
	table.insert(data.raw.technology["biochamber"].effects, { type = "unlock-recipe", recipe = "biolubricant" })
	local bioflux_processing_tech = data.raw.technology["bioflux-processing"]
	for i,effect in pairs(bioflux_processing_tech.effects) do
		if effect.recipe == "biolubricant" then
			table.remove(bioflux_processing_tech.effects, i)
			break
		end
	end
end

if settings.startup["gleba-reborn-useful-wood-fish"].value then
	-- Fish breeding
	update_recipe("fish-breeding", "nutrients", "tree-seed", 2)
	
	local fish_breeding = data.raw.technology["fish-breeding"]
	fish_breeding.unit = nil
	fish_breeding.research_trigger = {
		count = 1,
		item = "tree-seed",
		type = "craft-item"
	}

	-- Tree seeding
	local tree_seeding = data.raw.technology["tree-seeding"]
	tree_seeding.prerequisites = { "biochamber" }
	tree_seeding.unit = nil
	tree_seeding.research_trigger = {
		count = 25,
		item = "biochamber",
		type = "craft-item"
	}
	
	-- 250 seeds per rocket
	data.raw.item["tree-seed"].weight = 4000
	data.raw.item["jellynut-seed"].weight = 4000
	data.raw.item["yumako-seed"].weight = 4000
	
	-- Artificial Tree Soil
	table.insert(data.raw.technology["artificial-soil"].effects, { type = "unlock-recipe", recipe="gleba-reborn-artificial-tree-soil" })
	
	-- Don't allow trees to be farmed on desert tiles. Only specific types of sand disallow tree farming in the base game for some reason.
	local treeTiles = data.raw.plant["tree-plant"].autoplace.tile_restriction
	for i = #treeTiles, 1, -1 do
		if treeTiles[i] == "dirt-1"
				or treeTiles[i] == "red-desert-1"
				or treeTiles[i] == "red-desert-2"
				or treeTiles[i] == "red-desert-3" then
			table.remove(treeTiles, i)
		end
	end
end

if settings.startup["gleba-reborn-extra-biochamber-recipes"].value then
	-- New crafting category for recipes that can be made in both the biochamber and the centrifuge
	table.insert(data.raw["assembling-machine"]["biochamber"].crafting_categories, "organic-or-centrifuging")
	table.insert(data.raw["assembling-machine"]["centrifuge"].crafting_categories, "organic-or-centrifuging")
	
	table.insert(data.raw.technology["biochamber"].effects, { type = "unlock-recipe", recipe = "gleba-reborn-synthetic-nutrients" })
	
	set_recipe_category("ice-melting", "organic-or-chemistry")
	set_recipe_category("thruster-fuel", "organic-or-chemistry")
	set_recipe_category("thruster-oxidizer", "organic-or-chemistry")
	set_recipe_category("advanced-thruster-fuel", "organic-or-chemistry")
	set_recipe_category("advanced-thruster-oxidizer", "organic-or-chemistry")
	set_recipe_category("solid-fuel-from-heavy-oil", "organic-or-chemistry")
	set_recipe_category("solid-fuel-from-light-oil", "organic-or-chemistry")
	set_recipe_category("solid-fuel-from-petroleum-gas", "organic-or-chemistry")
	set_recipe_category("coal-synthesis", "organic-or-chemistry")
	set_recipe_category("lubricant", "organic-or-chemistry")
	set_recipe_category("biolab", "organic")
	set_recipe_category("uranium-processing", "organic-or-centrifuging")
	set_recipe_category("kovarex-enrichment-process", "organic-or-centrifuging")
	set_recipe_category("nuclear-fuel", "organic-or-centrifuging")
end

if settings.startup["gleba-reborn-better-soil"].value then
	-- Artificial soil can be placed anywhere in the green/purple biome, overgrowth soil can be placed anywhere on gleba.
	local artificial_jellynut_tile_rules = data.raw.item["artificial-jellynut-soil"].place_as_tile
	artificial_jellynut_tile_rules.tile_condition = jellynut_biome_tiles
	artificial_jellynut_tile_rules.condition.layers = {}

	local artificial_yumako_tile_rules = data.raw.item["artificial-yumako-soil"].place_as_tile
	artificial_yumako_tile_rules.tile_condition = yumako_biome_tiles
	artificial_yumako_tile_rules.condition.layers = {}

	local overgrowth_jellynut_tile_rules = data.raw.item["overgrowth-jellynut-soil"].place_as_tile
	overgrowth_jellynut_tile_rules.tile_condition = all_gleba_tiles

	local overgrowth_yumako_tile_rules = data.raw.item["overgrowth-yumako-soil"].place_as_tile
	overgrowth_yumako_tile_rules.tile_condition = all_gleba_tiles
end

if settings.startup["gleba-reborn-more-seeds"].value then
	-- Base seed chance is 2%, increase to 5% to speed things up when setting up farms
	update_result_probability("yumako-processing", "yumako-seed", 0.05)
	update_result_probability("jellynut-processing", "jellynut-seed", 0.05)
end

if settings.startup["gleba-reborn-hungry-biolab"].value then
	data.raw.lab.biolab.energy_source = {
		burner_usage = "nutrients",
		effectivity = 1,
		emissions_per_minute = {
			pollution = -1
		},
		fuel_categories = {
			"nutrients"
		},
		fuel_inventory_size = 1,
		type = "burner"
	}
end

if settings.startup["gleba-reborn-less-enemies"].value then
	local less_enemies_setting = settings.startup["gleba-reborn-less-enemies"].value
	if less_enemies_setting ~= "normal" then
		local pentapod_spawns = data.raw["unit-spawner"]["gleba-spawner"].result_units
		if settings.startup["gleba-reborn-less-enemies"].value == "start" then
			update_enemy_spawns(pentapod_spawns, pentapod_spawns_start_less)
		elseif settings.startup["gleba-reborn-less-enemies"].value == "always" then
			update_enemy_spawns(pentapod_spawns, pentapod_spawns_always_less)
		end
	end
end

if settings.startup["gleba-reborn-reset-science-spoilage"].value then
	local science_recipe = data.raw.recipe["agricultural-science-pack"]
	if science_recipe then
		science_recipe.reset_freshness_on_craft = true
	end
end



if settings.startup["gleba-reborn-nutrient-spoil-time"].value then
	set_item_spoil_time("nutrients", settings.startup["gleba-reborn-nutrient-spoil-time"].value)
end

if settings.startup["gleba-reborn-bacteria-spoilage"].value then
	set_item_spoil_result("iron-bacteria", "spoilage")
	set_item_spoil_result("copper-bacteria", "spoilage")
end

if settings.startup["gleba-reborn-bacteria-spoil-time"].value then
	set_item_spoil_time("iron-bacteria", settings.startup["gleba-reborn-bacteria-spoil-time"].value)
	set_item_spoil_time("copper-bacteria", settings.startup["gleba-reborn-bacteria-spoil-time"].value)
end

if settings.startup["gleba-reborn-science-spoil-time"].value then
	set_item_spoil_time("agricultural-science-pack", settings.startup["gleba-reborn-science-spoil-time"].value)
end





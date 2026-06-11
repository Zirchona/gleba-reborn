
require("common")
require("prototypes/recipes")


-- Copy recipes to preserve any changes made by other mods
if settings.startup["gleba-reborn-extra-biochamber-recipes"].value then
	-- Add nuclear recipes to biochamber
	copy_recipe_to_category("uranium-processing", "organic")
	copy_recipe_to_category("kovarex-enrichment-process", "organic")
	copy_recipe_to_category("nuclear-fuel", "organic")
	
	-- Allow nutrient recipes to be crafted in assembling machines
	copy_recipe_to_category("nutrients-from-bioflux", "advanced-crafting")
	copy_recipe_to_category("nutrients-from-yumako-mash", "advanced-crafting")
end
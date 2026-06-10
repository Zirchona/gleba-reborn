
require("common")
require("prototypes/recipes")


-- Compatibility fixes

if mods["bobassembly"] and bobmods then
	bobmods.lib.machine.copy_categories_from("assembling-machine", "centrifuge", "bob-centrifuge-2")
	bobmods.lib.machine.copy_categories_from("assembling-machine", "centrifuge", "bob-centrifuge-3")
end
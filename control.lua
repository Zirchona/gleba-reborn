

local function randomize_growth(plant)
	-- Plus or minus 30 seconds to the grow time
	plant.tick_grown = plant.tick_grown + math.random(-30 * 60, 30 * 60)
end

if settings.startup["gleba-reborn-random-growth"].value then
	script.on_event(defines.events.on_tower_planted_seed , function(event)
		randomize_growth(event.plant)
	end)
end
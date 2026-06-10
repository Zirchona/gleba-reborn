
local ten_seconds_in_ticks = 10 * 60
local thirty_seconds_in_ticks = 30 * 60


local function randomize_growth(plant)
	local pos_seed = (plant.position.x + plant.position.y) % 5
	
	-- Increase or decrease average modification based on plant position, to make them spread out from each other over time
	if pos_seed < 2.5 then
		plant.tick_grown = plant.tick_grown + math.random(-ten_seconds_in_ticks, thirty_seconds_in_ticks)
	else
		plant.tick_grown = plant.tick_grown + math.random(-thirty_seconds_in_ticks, ten_seconds_in_ticks)
	end
end

if settings.startup["gleba-reborn-random-growth"].value then
	script.on_event(defines.events.on_tower_planted_seed, function(event)
		randomize_growth(event.plant)
	end)
end
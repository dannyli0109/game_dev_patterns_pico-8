pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
	start_game()
end

function _updated60()


end

function _draw()
	cls()
	
	for w in all(weapons) do
		for k, v in pairs(w) do
			if type(v)!="function" then
				print(k..': '..v)
			end
		end
		print("")
	end
	
	
end

function start_game()
	weapons = {}
	
	-- weapon prototype (base class)
	weapon = create_thing(
		{
			attack=function()
				print('attack')
			end,
			range=10,
			damage=10,
			name="base weapon"
		}
	)
	
	add(weapons,weapon)
	
	-- sword with weapon as prototype
	sword = create_thing(
		{
			range=16,
			name="sword"
		},
		weapon
	)
	
	add(weapons,sword)
	
	-- giant sword with sword as prototype
	giant_sword = create_thing(
		{
			range=50,
			damage=50,
			name="giant_sword"
		},
		sword
	)
	
	add(weapons,giant_sword)

end
-->8
--prototype

function create_thing(thing, prototype)
	local t = {}
	prototype = prototype or {}
	
	--adding all prototype properties into the object
	for p,v in pairs(prototype) do
		t[p] = v
	end
	
	--override all the properties with the thing object
	for p,v in pairs(thing) do
		t[p] = v
	end
	return t
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

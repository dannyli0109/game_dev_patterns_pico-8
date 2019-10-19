pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--main
skill_data = {
	{
		name= "fire ball lvl1",
		attack = "10",
		cost = "20"
	},
	{
		parent= "fire ball lvl1",
		name= "fire ball lvl2",
		attack = "20"
	},
	{
		parent= "fire ball lvl2",
		name= "fire ball lvl3",
		cost = "23"
	}
}

monster_data = {
	{
		name= "slime",
		attack = "10",
		defence = "20"
	},
	{
		parent= "slime",
		name= "blue slime",
		attack = "20"
	},
	{
		name= "red slime",
		parent= "blue slime",
		defence = 99
	}
}


function _init()
	skills = create_from_data(skill_data)
	monsters = create_from_data(monster_data)
end


function _update60()
end


function _draw()
	cls()
	print_pair(skills)
	print("----------------")
	print_pair(monsters)
end


-->8
function print_pair(pair, level)
	level = level or 0
	for k,v in pairs(pair) do
		local left = k
		local right = v
		local typ = type(right)
		local space = ""
		for i=0,level do
			space = space.."  "
		end
		if (typ == "table") then
			print(space..left..": ")
			print_pair(right, level+1)
		else
			print(space..left..": "..right)
		end
	end
end
-->8
--create objects from data 
function create_from_data(data)
	cls()
	local output = {}
	for i=1,#data do
		output[data[i].name] = new_object(output, data[i])
	end
	return output
end

function new_object(objects, obj)
	local o = {}
	if obj.parent then
		parent = objects[obj.parent] or {}
		for k,v in pairs(parent) do
				if (k != "parent" and k != "name") then
					o[k] = v
				end
		end
	end	
	
	for k,v in pairs(obj) do
		if k != "parent" and k != "name" then
			o[k] = v
		end
	end
	return o
end

__gfx__
00000000007777000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000701710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700700770071771000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000707007071777100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000707007071777710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700700770071771100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000070000700117100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

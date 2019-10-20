pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
	start_game()
end

function _update60()
	update_game()
end

function _draw()
	draw_game()
end

function start_game()
	dir_x = {-1,1,0,0}
	dir_y = {0,0,-1,1}
	player = create_player(0,0)
end
-->8
-- update game

function update_game()
	player.update()
end
-->8
-- draw game

function draw_game()
	cls()
	player.draw()
end
-->8
--game object
function create_game_object(_x,_y)
	local o = {}
	o.x = _x
	o.y = _y
	o.vx = 0
	o.vy = 0
	return o
end

function create_player(_x,_y)
	local p = create_game_object(_x,_y)
	
	p.input = create_input_component()
	p.physics = create_physics_component()
	p.graphics = create_graphics_component()
	
	p.update = function()
		p.input.update(p)
		p.physics.update(p)
	end
	
	p.draw = function()
		p.graphics.update(p)
	end
	
	return p
end
-->8
--components
function create_input_component()
	local ic = {}
	ic.update = function(_game_object)
		_game_object.vx = 0
		_game_object.vy = 0
		for i=0,3 do 
			if btn(i) then
				_game_object.vx += dir_x[i+1]
				_game_object.vy += dir_y[i+1]
			end
		end
	end
	return ic
end


function create_physics_component()
	local pc = {}
	pc.update = function(_game_object)
		_game_object.x += _game_object.vx
		_game_object.y += _game_object.vy
	end
	return pc
end


function create_graphics_component()
	--should pass in sprites in real code
	local gc = {}
	gc.update = function(_game_object)
		rectfill(_game_object.x, _game_object.y, _game_object.x + 5, _game_object.y + 5)	
	end
	return gc
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

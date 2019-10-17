pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--main
function _init()
	start_game()
end

function _update60()
	handle_input()
	update_game()
end


function _draw()
	cls()
	print('x: '..actor.x)
	print('y: '..actor.y)
	print('commands: '..#commands)
	draw_game()
	
end

function start_game()
	commands = {}
	dir_x = {-1,1,0,0}
	dir_y = {0,0,-1,1}
	current_command=0
	actor={
		x=30,
		y=30,
		vx=0,
		vy=0
	}

	actor.move_to = function(_x,_y)
		actor.x = _x
		actor.y = _y
	end
end


-->8
--update


function handle_input()
	if (btn(❎)) then
		undo_commands(4)
	else
		for i=0,3 do
			if (btn(i)) then
	 		local mov_x = dir_x[i + 1]
	 		local mov_y = dir_y[i + 1]
	 		add(commands, new_move_command(actor, actor.x + mov_x, actor.y + mov_y))
	 		execute_commands()
	 	else
	 		add(commands, new_move_command(actor, actor.x, actor.y))
	 		execute_commands()
	 	end
		end
	end
end


function update_game()
	execute_commands()
end

function execute_commands()
	while current_command < #commands do
		current_command+=1
		commands[current_command].execute()
	end
	
	-- keep one second of data
	if (#commands > 240) then
	 del(commands, commands[1])
	 current_command-=1
	end
end

function undo_command()
	if (current_command <= #commands and current_command != 0) then
		commands[current_command].undo()
		del(commands, commands[current_command])
		current_command-=1
	end
end

function undo_commands(times)
	local current = 0
	while(current < times) do
		undo_command()
		current+=1
	end
end
-->8
--draw

function draw_game()
	draw_actor_paths(240)
	draw_actor()
end

function draw_actor()
	rectfill(actor.x, actor.y, actor.x+5, actor.y+5,8)
end

function draw_actor_paths(times)
	for i=0,times-1 do
		if i < current_command then
			rectfill(
				commands[current_command-i].x_before,
				commands[current_command-i].y_before,
				commands[current_command-i].x_before + 5,
				commands[current_command-i].y_before + 5, 
			7)
		end
	end
end
-->8
--commands
-----------
--move
-----------
function new_move_command(_actor,x,y)
	local _x_before = _actor.x
	local _y_before = _actor.y
	
	return {
		execute=function()
			_actor.move_to(x,y)
		end,
		undo=function() 
			_actor.move_to(_x_before,_y_before)
		end,
		x_before = _x_before,
		y_before = _y_before
	}
end
-->8
--characters
function move_actor(actor, x, y)
	actor.x = x
	actor.y = y
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

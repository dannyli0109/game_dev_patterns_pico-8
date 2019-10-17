pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--main
function _init()
	start_game()
end

function _update60()
	handle_input()
end

function _draw()
	cls()
	draw_game()
	print("dist: "..actor.dist)
	for ach in all(achievements) do
		print(ach.typ)
		print("achievement unlocked:")
		print(ach.unlocked)
	end
end

function start_game()
	achievements = {}
	dir_x = {-1,1,0,0}
	dir_y = {0,0,-1,1}
	dist = {0,0,0,0}
	subject = new_subject()
	actor={
		x=30,
		y=30,
		dist=800
	}
	actor.subject=subject
	actor.move_to = function(_x,_y)
		local mx = _x - actor.x
		local my = _y - actor.y
		actor.dist = actor.dist+abs(mx)+abs(my)	
		actor.x = _x
		actor.y = _y
		return subject
	end
	
	create_achievement("move 1000")
	
	--register observer
	actor.move_to(actor.x,actor.y)
		.add(new_achievement_observer())
end

-->8
--update

function handle_input()
	for i=0,3 do
		if (btn(i)) then
 		local mov_x = dir_x[i + 1]
 		local mov_y = dir_y[i + 1]
 		actor
 			.move_to(actor.x+mov_x, actor.y+mov_y)
 			.notify(actor, "move")
 	end
	end
end

function create_achievement(_typ)
	local ach = {
		typ=_typ,
		unlocked=false
	} 
	ach.unlock = function()
		ach.unlocked=true
	end
	
	add(achievements, ach)
	return ach
end


-->8
--draw

function draw_game()
	rectfill(actor.x, actor.y, actor.x+5, actor.y+5,8)
end
-->8
--observer

function new_subject()
	local s = {
		observers={}
	}
	
	s.add = function(observer)
		add(s.observers, observer)
	end
	
	s.del = function(observer)
		del(s.observers, observer)
	end
	
	s.notify = function(entity, event) 
		for o in all(s.observers) do
			o.on_notify(entity, event)
		end
	end
	
	return s
end


function new_achievement_observer()
	local o = {
	}
	o.unlock=function(achievement)
		achievement.unlock()
	end	
	
	o.on_notify=function(entity, event)
		if entity == actor then
			a=entity.dist
			if entity.dist > 1000 then
				o.unlock(achievements[1])
			end
		end
	end
	
	return o
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

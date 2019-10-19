pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--main
function _init()
	pervious = time()
	updates = 0
end

function _update60()
	current = time()
	local elapsed = current - pervious
	update_game(elapsed)
	draw_game()
	pervious = current
end

-->8
--update
function update_game(elapsed)
	c = {}
	local x = map_val(sin(time() * 60 * elapsed), -1, 1, 0, 128-5)
	local y = 64
	local w = 5
	for i=0,100 do
		cc = {}
		cc.x = x
		cc.y = y
		cc.w = w
		add(c,cc)
	end
	updates+=1
end
-->8
--draw
function draw_game()
	cls()
	for cc in all(c) do
		local x = cc.x
		local y = cc.y
		rectfill(x, y, x+cc.w, y+cc.w,10)
	end
end
-->8
--tool

--[[
	map value from s1-s1 to s2-s2
		0.5 0 1 0 256 returns 128
	]]
function map_val(_val, start1, stop1, start2, stop2)
	return (_val - start1) * (stop2 - start2) / (stop1 - start1) + start2
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

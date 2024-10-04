---------------------------------------------------------------------------------------------------------------------------------
----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----
---------------------------------------------------------------------------------------------------------------------------------
-- By Xpudding


PDS={
    set_palete = function(s, pal)
        local addr= 0x03FC0
        for i = 0, 45, 3 do
            local id_color = i//3

            poke(addr+id_color,   pal[id_color].r)
            poke(addr+id_color+1, pal[id_color].g)
            poke(addr+id_color+2, pal[id_color].b)

        end
    end,
    rect = function(s, display, pos, size, color)
        PDS:add_render(0, 
            function()
                local res = size* display.scale
                local pos = pos * display.scale

                rect(pos.x, pos.y, res.x, res.y, color)
            end
        )
    end,
    ord_render = {},
    add_render = function(s, layer, render)
        s.ord_render[layer] = render
    end,
    clear_screen = function(s)
        for k, v in ipairs(s.ord_render) do
            table.remove(s.ord_render, k)
        end
    end,
    render = function(s)
        for k, render in ipairs(s.ord_render) do
            render()
        end
    end
}------------------------------------------------------------------------------------------------------------------------------------
----Pudim system Processing unit----Pudim system Processing unit----Pudim system Processing unit----Pudim system Processing unit----
------------------------------------------------------------------------------------------------------------------------------------
-- By Xpudding

local debug = false

local function create_routine(c, t)
    return coroutine.create(
        function()
            for i = 1, t do
                for i, v in ipairs(c) do
                    v.proc()
                    coroutine.yield()
                end
            end
        end
    )
end

proc = {
    cores = {
        _1 = {},
        _2 = {},
        _3 = {}
    },
    running = function(s)
        local c1 = create_routine(s.cores._1, 1)
        local c2 = create_routine(s.cores._2, 2)
        local c3 = create_routine(s.cores._3, 3)

        for i = 1, 3 do
            if coroutine.status(c1) ~= 'dead' then
                coroutine.resume(c1)
            end
            if coroutine.status(c2) ~= 'dead' then
                coroutine.resume(c2)
            end
            if coroutine.status(c3) ~= 'dead' then
                coroutine.resume(c3)
            end
        end
        if debug then
            print("running success")
        end
    end,
    add = function(s, n, proc)
        s.cores['_' .. n][#s.cores['_' .. n]+1] = {
            proc = proc or function() print("no_process_or_this_is_a_test".. 1) end
        }
    end

}


if debug then 
    proc:add(1, function ()
     print(11111)
    end)
    proc:add(1, function ()
        print(2)
       end)
    proc:add(2, function ()
        print(90)
    end)
    proc:add(3, function ()
        print(445)
    end)
                 
    
    proc:running()
end

----------------------------------------------------------------------------------------------------------------------------
----Pudim vector Bidimencional----Pudim vector Bidimencional----Pudim vector Bidimencional----Pudim vector Bidimencional----
----------------------------------------------------------------------------------------------------------------------------
-- By Xpudding

local debug = false

function PVB(x, y) end

local meta = {}

meta.__add = function(a, b)
    return PVB(a.x+b.x,a.y+b.y)
end

meta.__sub = function(a, b)
    return PVB(a.x-b.x,a.y-b.y)
end

meta.__mul = function(a, b)
    if type(b) =="table" then
     return PVB(a.x*b.x,a.y*b.y)
    else
     return PVB(a.x*b,a.y*b)
    end	
end

meta.__div = function(a, b)
    if type(b) =="table" then
    return PVB(a.x/b.x,a.y/b.y)
    else
    return PVB(a.x/b,a.y/b)
    end
end

meta.__mod = function(a, b)
    return PVB(a.x%b.x,a.y%b.y)
end

meta.__pow = function(a, b)
    return PVB(a.x^b.x,a.y^b.y)
end

meta.__unm = function(a)
    return PVB(-a.x,-a.y)
end

meta.__idiv = function(a, b)
    if type(b) =="table" then
     return PVB(a.x//b.x,a.y//b.y)
    else
    return PVB(a.x//b,a.y//b)
    end
end

meta.__tostring = function(a)
    return "x: ".. a.x .."  y: ".. a.y
end

meta.__eq = function(a, b)
    if a.x==b.x and a.y==b.y then
        return true
    end
end

meta.__index = function ()
    return PVB(0,0)
end

function PVB(x,y)
    assert(type(x) == 'number' and type(y) == 'number', "x e y não são numero")
    assert(type(x) == 'number', "x não é numero")
    assert(type(y) == 'number', "y não é numero")
    
    local v={x=x or 0,y=y or 0}
    setmetatable(v,meta)
    return v
end

if debug then
    print(PVB(2, 3)*PVB(3, 2)) 
end 

-------------------------------------------------------------------------------------------------------------------------------------------------------------
----Read-Only Memory Manipulation Unit Pudim System----Read-Only Memory Manipulation Unit Pudim System----Read-Only Memory Manipulation Unit Pudim System----
-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- By Xpudding




local set_color_system = function()
    for i = 0, 15 do  
        poke(0x03fc0+i*3+1, i*(255/15))
        poke(0x03fc0+i*3+2, i*(255/15))
        poke(0x03fc0+i*3+3, i*(255/15))
      
    end
end

storage = {

    set_bit = function(s, addr,  value)
        local addr = addr + 0x04000
        assert(addr<=(0x0ff7f), "endereço muito grande")
        assert(addr>=(0x04000), "endereço muito pequeno")
        poke(addr, value)
    end,
    
    get_bit = function (s, addr)
        local addr = addr + 0x04000
        assert(addr<=(0x0ff7f), "endereço muito grande")
        assert(addr>=(0x04000), "endereço muito pequeno")
        return peek(addr)
    end,
    
    set_bytes = function(s, addr,  v)
        local addr = addr*8
        for i = 0, 7 do
            s:set_bit(addr+ i,     v[i])
        end
    end,
    
    get_bytes = function (s, addr)
        local v={}
        local addr = (addr//8)*8
        for i = 0, 7 do
            v[i] = s:get_bit(addr+ i)
        end
        return v
    end,
    save_memory = function (s)
        for BANK = 0, 7 do
            sync(0, BANK, true)
        end
    end,
    
    load_memory = function (s)
        for BANK = 0, 7 do
            sync(0, BANK, false)
        end
    end,
    
    init = function(s, initFunctions)
        set_color_system()
        s:load_memory()
        if type(initFunctions) == "function" then
            initFunctions(s)    
        end
    end
}

local debug_lua = false
local debug_TIC80 = false


if debug_TIC80 and not debug_lua then
    set_color = function()
        for i = 0, 15 do  
            poke(0x03fc0+i*3+1, i*(256/15))
            poke(0x03fc0+i*3+2, i*(256/15))
            poke(0x03fc0+i*3+3, i*(256/15))
          
        end
    end
    function show_memory_bank(_bank)
        vbank(_bank)
        set_color()
        for i = 0, 0x0ff7f-0x04000 do
            pix(i%240, (i//240), storage:get_bit(i))
        end
    end
    local select_ = 0
    local t = 0
    function TIC()
        cls(15)
        if btn(4) then
            select_= select_+1
            t=0
        end
        if select_ > 7 then
           select_=0 
        end
        if btn(5) then
            for i =0, 8000 do
                storage:set_bit(i, i, math.random(0, 7))
            end
        end

        show_memory_bank(select_)

        t=t+1
        if btn(6) then
            storage:save_memory()
        end
        print(select_)
    end
end

-- title:   PudimSystem
-- author:  Xpudding
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

--package.path = package.path .. ";/home/davi/.local/share/com.nesbox.tic/TIC-80/pudimSystem/?.lua"
--package.path = package.path .. ";/home/davi/.local/share/com.nesbox.tic/TIC-80/pudimSystem/system/?.lua"

--require("system.PSPU")
--require("system.PDS")
--require("system.ROMMUPS")
--require("system.PVB")

OS={}

OS.config = {}
  OS.config.diplay = {size = PVB(240, 136), scale = 0.5}
  OS.config.diplay.screen = OS.config.diplay.size / OS.config.diplay.scale

OS.storeage={
  cookingSpace={}
}

OS.services = {
  ___run_services = function(s)
    proc:add(2, 
      function()  
        for k, v in pairs(s[1]) do
          v()
        end
      end)
  end,
  [1] = {
    view_cookingSpace = function() 
      PDS:rect(OS.config.diplay, PVB(0,0), OS.config.diplay.screen, 15)
    end
  }
}


function BDR()
end

function BOOT()
  storage:init(function(s)
    
  end)
  OS.services.___run_services()
  proc:add(1, function() PDS:clear_screen() end)
  proc:add(3, function() PDS:render() end)
end

function TIC()
  cls(t)
  
end


-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>


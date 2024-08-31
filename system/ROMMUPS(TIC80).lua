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


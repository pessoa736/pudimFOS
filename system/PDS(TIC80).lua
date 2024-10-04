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
}
---------------------------------------------------------------------------------------------------------------------------------
----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----Pudim Drawings Sistem----
---------------------------------------------------------------------------------------------------------------------------------
-- By Xpudding

color_id ={}
    for i = 0,9 do
        color_id[tostring(i)] = i
    end
    color_id['a']=10
    color_id['b']=11
    color_id['c']=12
    color_id['d']=13
    color_id['e']=14
    color_id['f']=15

PDS = {
    UI ={
        rect = function(PDS, pos, size, color)
            local u ={ 
                pos = pos or PVB(0, 0),
                size = size or PVB(4, 4),

                draw = function(s)
                    rect(s.pos.x, s.pos.y, s.size.x, s.size.y, color)
                end
            }
            table.insert(PDS.drawings, u)
        end,
        imag = function(PDS, data, pos, size)
            local img = {
                data = data or "-064-064-",
                pos = pos or PVB(0, 0),
                size = size or PVB(64, 64),
                draw = function(s)
                    local rx = tonumber(string.sub(s.data, 1, 4)) 
                    local ry = tonumber(string.sub(s.data, 6, 9))
                    for i = 0, rx*ry do
                        local x = s.pos.x+i%rx
                        local y = s.pos.y+(i//rx)%ry
                        pix(x,y,color_id[string.sub(s.data, i+9, i+9)])
                    end 
                end
            }
            table.insert(PDS.drawings, img)
        end
    },
    drawings = {},
    draw = function(s)
        for i, d in ipairs(s) do
            pcall(function()
                d:draw()
                s[i] = nil
            end)
        end
    end
}

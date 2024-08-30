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


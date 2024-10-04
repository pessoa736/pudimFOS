------------------------------------------------------------------------------------------------------------------------------------
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


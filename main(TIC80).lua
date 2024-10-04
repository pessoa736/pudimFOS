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


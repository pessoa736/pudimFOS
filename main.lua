-- title:   PudimSystem
-- author:  Xpudding
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

package.path = package.path .. ";/home/davi/.local/share/com.nesbox.tic/TIC-80/pudimSystem/?.lua"
package.path = package.path .. ";/home/davi/.local/share/com.nesbox.tic/TIC-80/pudimSystem/system/?.lua"

require("system.PSPU")
require("system.PDS")
require("system.ROMMUPS")
require("system.PVB")





function BDR()
  PDS:draw()
end

function BOOT()
  storage:init(function(s)
    s:set_bytes(0, {0,0,0,0,0,0,0,0}) -- action = {1 = copy, 2 = move, 3 = delete, 0 = none}
    s:set_bytes(1, {0,0,0,0,0,0,0,0}) -- value addr selection1

    s:set_bytes(3, {0,0,0,0,0,0,0,0}) -- addr 1
    s:set_bytes(4, {0,0,0,0,0,0,0,0}) -- addr 2
  end)
end

function TIC()
  cls(t)
  
end


-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>


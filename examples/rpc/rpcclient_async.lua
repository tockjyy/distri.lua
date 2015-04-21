local Sche = require "lua.sche"
local NameService = require "examples.rpc.toname"
local RpcHandle = require "examples.rpc.rpchandle"

NameService.Init("127.0.0.1",8080)

for i=1,10 do
	Sche.Spawn(function () 
		local rpc = RpcHandle.FindService("Plus")
		if not rpc then
			print("no Plus service")
			return
		end
		local function callback(err,result)
			if not err then
				rpc:CallAsync(callback,1,2)
			else
				if err == "socket error" then
					rpc = RpcHandle.FindService("Plus")
					if not rpc then
						return
					end
				end
			end
		end		
		for j=1,100 do			
			rpc:CallAsync(callback,1,2)	
		end
	end)	
end

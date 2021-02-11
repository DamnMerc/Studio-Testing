local HoloService = require(script.HoloService)
local Players = game:GetService('Players')
local function PlayerJoined(Player)
	local CallCheck = HoloService:GetCalls()
	local CreateCall = HoloService:new("Operation Cinder")
	if #CallCheck > 0 then
		CallCheck[1]:AddMember(Player)
        print('hti t')
		print(#CallCheck[1].Members)
		print('hi')
        print('hi there?')
	else
		CreateCall:AddMember(Player)
		print(#CreateCall.Members)
	end
end

Players.PlayerAdded:Connect(PlayerJoined)
local HoloService = require(game.ReplicatedStorage.Modules.HoloService)
local Players = game:GetService('Players')
HoloService:init()
local function PlayerJoined(Player)
	Player:SetAttribute('Call_Status','None')
	print(Player,'joined')
	local Call = HoloService:newCall()
	Call:on('ready',function()
		print('Call is ready')
		local try = Call:addMember(Player)
		if not try then
			print('Person in call?')
		end
	end)
	Call:on('disband',function()
		local mat = (tick()-Call.created)
		print('Call lasted',math.floor(mat),'seconds')
	end)
	Call:on('newMessage',function(Data)
		print(Data)
		if (Data.message == "disband") then
			Call:Disband()
		end
	end)
end
for i,v in next, Players:GetChildren() do
	PlayerJoined(v)
end
Players.PlayerAdded:Connect(PlayerJoined)
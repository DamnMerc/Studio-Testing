local Class = require(3696101309)
local Calls = {}
local Http = game:GetService("HttpService")
local HoloService = Class() do
	function HoloService:init() -- The function ':init()' is called automatically when your object is instantiated.
		print('[HoloService]: Initialized')
	end
end
function HoloService:newCall()
    local this = self
	local HoloCall = Class() do
		function HoloCall:init() -- The function ':init()' is called automatically when your object is instantiated.
			self.members = {}
			self.chatHistory = {}
			self.id = Http:GenerateGUID(false)
			self.created = tick()
			self.Event = Instance.new('BindableEvent')
			spawn(function()
				delay(0.3,function()
					self.Event:Fire('ready')
				end)
			end)
		end
		function HoloCall:Disband()
			table.remove(Calls, table.find(Calls, self.id))
			for i,v in next, self.members do
				for _,connection in next, v.connections do
					connection:Disconnect()
				end
				table.remove(self.members,i)
			end
			self.Event:Fire('disband')
		end
		function HoloCall:addMember(Player)
			if Player:GetAttribute('Call_Status') == 'In_Call' then return false end
			local profile = {}
			profile.playerObj = Player
			profile.connections = {}
			profile.connections[#profile.connections+1] = Player.Chatted:Connect(function(Message)
				local chatTemplate = {}
				chatTemplate.timestamp = os.time()
				chatTemplate.author = Player.Name
				chatTemplate.message = Message
				table.insert(self.chatHistory,chatTemplate)
				self.Event:Fire('newMessage',chatTemplate)
			end)
			Player:SetAttribute('Call_Status','In_Call')
			table.insert(self.members,profile)
			return profile
		end
	end
	function HoloCall:on(Name, funct)
		self.Event.Event:Connect(function(type,data)
			if type == Name then
				funct(data)
			end
		end)
	end
	return HoloCall ()
end

return HoloService
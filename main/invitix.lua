local module = {}
module.__index = module


local properties = {
	[1] = "PromptMessage";
	[2] = "InviteMessageId";
	[3] = "LaunchData";
}
function module.new()
	local t = setmetatable({},module)
	t[properties[1]] = ""
	t[properties[2]] = ""
	t[properties[3]] = {}
	return t
end

function module:edit(msg: string,messageId: any?,data: string?)
	if type(data) ~= "table" then
		print("Invitix\nLaunchData is not a table, replacing with black table.")
	end
	
	
	self[properties[1]] = msg
	self[properties[2]] = messageId or ""
	self[properties[3]] = data or ""
end

function module:prompt(plr: object)
	local inviteOptions = Instance.new("ExperienceInviteOptions")
	for i,v in pairs(properties) do
		inviteOptions[v] = self[v]
	end
	
	
	local SocialService = game:GetService("SocialService")
	local Players = game:GetService("Players")
	
	local function canSendGameInvite(sendingPlayer)
		local success, canSend = pcall(function()
			return SocialService:CanSendGameInviteAsync(sendingPlayer)
		end)
		return success and canSend
	end

	local canInvite = canSendGameInvite(plr)
	if canInvite then
		local success, errorMessage = pcall(function()
			SocialService:PromptGameInvite(plr, inviteOptions)
		end)
	end
	
	
end
return module

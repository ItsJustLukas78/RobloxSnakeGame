-- Server Script: Data Manager

local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetOrderedDataStore("TopPlayers")

game.ReplicatedStorage.Submit.OnServerEvent:Connect(function(Player, HighScore)
	if DataStore:GetAsync(Player.UserId) == nil then
		DataStore:SetAsync(Player.UserId, HighScore)
	else
		local Data = DataStore:GetAsync(Player.UserId)
		if Data < HighScore then
			DataStore:SetAsync(Player.UserId, HighScore)
		end
	end
	local AllData = DataStore:GetSortedAsync(false, 10)
	local DataPage = AllData:GetCurrentPage()
	game.ReplicatedStorage.Refresh:FireAllClients(DataPage)
end)

-- Local Script: GameManager

local Player = game.Players.LocalPlayer
local InputService = game:GetService("UserInputService")
local GameFrame = script.Parent.GameFrame
local SnakeGame = GameFrame.SnakeGame
local Running = false

local PlaySpaces = {
	[1] = {	
		[1] = "Position1",
		[2] = "Position2",
		[3] = "Position3",
		[4] = "Position4",
		[5] = "Position5",
		[6] = "Position6",
		[7] = "Position7",
		[8] = "Position8",
		[9] = "Position9",
		[10] = "Position10"
		
	}, 
	
	[2] = {
		[1] = "Position11",
		[2] = "Position12",
		[3] = "Position13",
		[4] = "Position14",
		[5] = "Position15",
		[6] = "Position16",
		[7] = "Position17",
		[8] = "Position18",
		[9] = "Position19",
		[10] = "Position20"
	}, 
	
	[3] = {	
		[1] = "Position21",
		[2] = "Position22",
		[3] = "Position23",
		[4] = "Position24",
		[5] = "Position25",
		[6] = "Position26",
		[7] = "Position27",
		[8] = "Position28",
		[9] = "Position29",
		[10] = "Position30"
	},
	
	[4] = {
		[1] = "Position31",
		[2] = "Position32",
		[3] = "Position33",
		[4] = "Position34",
		[5] = "Position35",
		[6] = "Position36",
		[7] = "Position37",
		[8] = "Position38",
		[9] = "Position39",
		[10] = "Position40"
	}, 
	
	[5] = {
		[1] = "Position41",
		[2] = "Position42",
		[3] = "Position43",
		[4] = "Position44",
		[5] = "Position45",
		[6] = "Position46",
		[7] = "Position47",
		[8] = "Position48",
		[9] = "Position49",
		[10] = "Position50"
	}, 
	
	[6] = {
		[1] = "Position51",
		[2] = "Position52",
		[3] = "Position53",
		[4] = "Position54",
		[5] = "Position55",
		[6] = "Position56",
		[7] = "Position57",
		[8] = "Position58",
		[9] = "Position59",
		[10] = "Position60"	
	},
	
	[7] = {
		[1] = "Position61",
		[2] = "Position62",
		[3] = "Position63",
		[4] = "Position64",
		[5] = "Position65",
		[6] = "Position66",
		[7] = "Position67",
		[8] = "Position68",
		[9] = "Position69",
		[10] = "Position70"
	},
	
	[8] = {
		[1] = "Position71",
		[2] = "Position72",
		[3] = "Position73",
		[4] = "Position74",
		[5] = "Position75",
		[6] = "Position76",
		[7] = "Position77",
		[8] = "Position78",
		[9] = "Position79",
		[10] = "Position80"
	},
	
	[9] = {
		[1] = "Position81",
		[2] = "Position82",
		[3] = "Position83",
		[4] = "Position84",
		[5] = "Position85",
		[6] = "Position86",
		[7] = "Position87",
		[8] = "Position88",
		[9] = "Position89",
		[10] = "Position90"
	}, 
	
	[10] = {
		[1] = "Position91",
		[2] = "Position92",
		[3] = "Position93",
		[4] = "Position94",
		[5] = "Position95",
		[6] = "Position96",
		[7] = "Position97",
		[8] = "Position98",
		[9] = "Position99",
		[10] = "Position100"
	}
	
}

local HeadYPosition = 5
local HeadXPosition = 3
local FoodYPosition = 5
local FoodXPosition = 7
local SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
local FoodSpace = SnakeGame[PlaySpaces[FoodYPosition][FoodXPosition]]
local SnakeLength = 0
local ActualSnakeLength = 0
local SnakeBody = {}
local SnakeHeadText = "😏"
local SnakeBodyText = "🟡"
local SnakeSadText = "😥"
local SnakeYumText = "😊"
local FoodText = "🍎"
local HighScore = 0
local Direction = "Right"
local Control 

local function EndGame()
	print("Lost")
	GameFrame.LostLabel.Visible = true
	if SnakeLength > HighScore then
		HighScore = SnakeLength
		GameFrame.HighScore.Text = "High score: " .. HighScore
	end
	SnakeHead.TextLabel.Text = SnakeSadText
	local DeathNoice = "Death" .. math.random(1,7)
	script[DeathNoice]:Play()
	Control()
end

local function RemoveTail()
	if SnakeLength == 0 then
		SnakeHead.TextLabel.Text = ""
	elseif SnakeLength > 0 then
		if ActualSnakeLength >= SnakeLength then
			SnakeHead.TextLabel.Text = SnakeBodyText
			table.insert(SnakeBody, SnakeHead)
			local Removed = table.remove(SnakeBody, 1)
			Removed.TextLabel.Text = ""
		else
			print("insert")
			table.insert(SnakeBody, SnakeHead)
			SnakeHead.TextLabel.Text = SnakeBodyText
			ActualSnakeLength += 1 
		end
	end
end

local function ChangeFood()
	FoodSpace.TextLabel.Text = FoodText
	local NewX, NewY
	repeat
		NewX, NewY = math.random(1, 10), math.random(1, 10)
	until SnakeGame[PlaySpaces[NewY][NewX]] ~= SnakeHead and table.find(SnakeBody, SnakeGame[PlaySpaces[NewY][NewX]]) == nil
	FoodSpace = SnakeGame[PlaySpaces[NewY][NewX]]
	FoodSpace.TextLabel.Text = FoodText
	SnakeLength += 1
	SnakeHead.TextLabel.Text = SnakeYumText
	script.Crunch:Play()
end

local function Up()
	HeadYPosition -= 1
	if HeadYPosition >= 1 and not table.find(SnakeBody, SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]) then 
		RemoveTail()
		SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
		SnakeHead.TextLabel.Text = SnakeHeadText
		if FoodSpace == SnakeHead then
			ChangeFood()
		end
	else
		EndGame()		
	end
end

local function Down()
	HeadYPosition += 1
	if HeadYPosition <= 10 and not table.find(SnakeBody, SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]) then 
		RemoveTail()
		SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
		SnakeHead.TextLabel.Text = SnakeHeadText
		if FoodSpace == SnakeHead then
			ChangeFood()
		end
	else
		EndGame()		
	end
end

local function Left()
	HeadXPosition -= 1
	if HeadXPosition >= 1 and not table.find(SnakeBody, SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]) then 
		RemoveTail()
		SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
		SnakeHead.TextLabel.Text = SnakeHeadText
		if FoodSpace == SnakeHead then
			ChangeFood()
		end
	else
		EndGame()		
	end
end

local function Right()
	HeadXPosition += 1
	if HeadXPosition <= 10 and not table.find(SnakeBody, SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]) then
		RemoveTail()
		SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
		SnakeHead.TextLabel.Text = SnakeHeadText
		if FoodSpace == SnakeHead then
			ChangeFood()
		end
	else
		EndGame()		
	end
end


local function ConstantMovement()
	while task.wait(0.2) do 
		if Direction == "Up" then
			Up()
		elseif Direction == "Down" then
			Down()
		elseif Direction == "Left" then
			Left()
		elseif Direction == "Right" then
			Right()
		end
		GameFrame.Score.Text = "Score: " .. SnakeLength
	end
end

local ConstantMovementCoroutine = coroutine.create(ConstantMovement)

local Controls = require(game.Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls()

Control = function()
	if coroutine.status(ConstantMovementCoroutine) == "suspended" then
		Controls:Disable()
		Running = true
		coroutine.resume(ConstantMovementCoroutine)
	elseif coroutine.status(ConstantMovementCoroutine) == "running" then
		Controls:Enable()
		Running = false
		coroutine.yield(ConstantMovementCoroutine)
	end
end

GameFrame.StartButton.MouseButton1Click:Connect(function()
	for _,GamePiece in ipairs(SnakeGame:GetDescendants()) do
		if GamePiece:IsA("TextLabel") then
			GamePiece.Text = ""
		end
	end
	HeadYPosition = 5
	HeadXPosition = 3
	FoodYPosition = 5
	FoodXPosition = 7
	SnakeHead = SnakeGame[PlaySpaces[HeadYPosition][HeadXPosition]]
	FoodSpace = SnakeGame[PlaySpaces[FoodYPosition][FoodXPosition]]
	SnakeLength = 0
	ActualSnakeLength = 0
	SnakeBody = {}
	SnakeHeadText = "😏"
	SnakeBodyText = "🟡"
	SnakeSadText = "😥"
	SnakeYumText = "😊"
	FoodText = "🍎"
	Direction = "Right"
	SnakeHead.TextLabel.Text = SnakeBodyText
	FoodSpace.TextLabel.Text = FoodText
	GameFrame.LostLabel.Visible = false
	Running = false
	Control()
end)

local RefreshDebounce = false

GameFrame.RefreshButton.MouseButton1Click:Connect(function()
	if RefreshDebounce == false then
		RefreshDebounce = true
		game.ReplicatedStorage.Submit:FireServer(HighScore)
		wait(5)
		RefreshDebounce = false
	end
end)

game.ReplicatedStorage.Refresh.OnClientEvent:Connect(function(DataPage)
	for _, TextLabel in ipairs(GameFrame.LeaderBoard:GetChildren()) do
		if TextLabel:IsA("TextLabel") then
			TextLabel:Destroy()
		end
	end
	for _, PlayerData in ipairs(DataPage) do
		local Label = game.ReplicatedStorage.TextLabel:Clone()
		print(PlayerData)
		local ID = tonumber(PlayerData.key)
		local Username = game.Players:GetNameFromUserIdAsync(ID)
		Label.Text = Username .. ": " .. PlayerData.value
		Label.Parent = GameFrame.LeaderBoard
	end
end)

InputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		local keyPressed = input.KeyCode
		if Running == true then
			if keyPressed == Enum.KeyCode.W or keyPressed == Enum.KeyCode.Up then
				if Direction ~= "Down" then
					Direction = "Up"	
				end
			elseif keyPressed == Enum.KeyCode.S or keyPressed == Enum.KeyCode.Down then
				if Direction ~= "Up" then
					Direction = "Down"	
				end
			elseif keyPressed == Enum.KeyCode.A or keyPressed == Enum.KeyCode.Left then
				if Direction ~= "Right" then
					Direction = "Left"	
				end
			elseif keyPressed == Enum.KeyCode.D or keyPressed == Enum.KeyCode.Right then
				if Direction ~= "Left" then
					Direction = "Right"	
				end
			end
		end
	end
end)

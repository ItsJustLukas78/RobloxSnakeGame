-- Local Script: Resizer

local frame = script.Parent
local ui = script.Parent.UIListLayout

local function UpdateSize()
	wait()--Ui list layouts can sometimes take time to update 
	local cS = ui.AbsoluteContentSize --X = x pixels, Y = Y pixels
	frame.CanvasSize = UDim2.new(0,cS.X,0,cS.Y) --Change that UDim into a UDim2
end

frame.ChildAdded:Connect(UpdateSize)
frame.ChildRemoved:Connect(UpdateSize)

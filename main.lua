local outsideData = {...}
local replicatedStorage = game:GetService("ReplicatedStorage")
local virtualUser = game:GetService("VirtualUser")
local players = game:GetService("Players")
local client = players.LocalPlayer
local damageEvent = replicatedStorage:WaitForChild("jdskhfsIIIllliiIIIdchgdIiIIIlIlIli")
local coinEvent = replicatedStorage:WaitForChild("Events"):WaitForChild("CoinEvent")
local NPCs = workspace:WaitForChild("NPC")
local TeleportService = game:GetService("TeleportService")
local jobId = game.JobId
local placeId = game.PlaceId
local revolutions, currentRevs, alwaysOn = 0, 0, true

local function spawnTask(func) task.spawn(func) end

spawnTask(function()
	while true do
		for _, entity in ipairs(NPCs:GetChildren()) do
			if entity:FindFirstChild("Humanoid") then
				local hitBoss = entity:FindFirstChild("Humanoid")
				local damageArgs = {[1] = hitBoss, [2] = 1}
				repeat
					damageEvent:FireServer(unpack(damageArgs))
					task.wait()
				until hitBoss.Health <= 0 or client.Character.Humanoid.Health <= 0
			end
		end
		task.wait(1)
	end
end)

spawnTask(function()
	while true do coinEvent:FireServer() task.wait(0.5) end
end)

spawnTask(function()
	client.Idled:Connect(function()
		virtualUser:CaptureController()
		virtualUser:ClickButton2(Vector2.new())
	end)
end)

local function rejoin()
	if #players:GetPlayers() <= 1 then
		client:Kick("GAME REJOIN")
		wait()
		TeleportService:Teleport(placeId, client)
	else
		TeleportService:TeleportToPlaceInstance(placeId, jobId, client)
	end
end

spawnTask(function()
	alwaysOn = outsideData[1]['alwaysOn']
	revolutions = outsideData[1]['revs']
end)

if alwaysOn then
	spawnTask(function()
		while true do
			currentRevs = currentRevs + 1
			if currentRevs >= revolutions then rejoin() end
			task.wait(0.01)
		end
	end)
end

print("TEM AUTO GRINDER STARTED\n\nThis will now run until you leave.")
--local rS=game:GetService("ReplicatedStorage");local vU=game:GetService("VirtualUser");local p=game:GetService("Players").LocalPlayer;local dE=rS:WaitForChild("jdskhfsIIIllliiIIIdchgdIiIIIlIlIli");local cE=rS:WaitForChild("Events"):WaitForChild("CoinEvent");local N=workspace:WaitForChild("NPC");local T=game:GetService("TeleportService");local jID=game.JobId;local pID=game.PlaceId;task.spawn(function()while true do for _,e in ipairs(N:GetChildren())do if e:FindFirstChild("Humanoid")then repeat dE:FireServer(e:FindFirstChild("Humanoid"),1);task.wait()until e:FindFirstChild("Humanoid").Health<=0or p.Character.Humanoid.Health<=0 end end task.wait(1)end end);task.spawn(function()while true do cE:FireServer();task.wait(.5)end end);task.spawn(function()p.Idled:Connect(function()vU:CaptureController();vU:ClickButton2(Vector2.new())end)end);local r=#p:GetPlayers()<=1 and function()T:Teleport(pID,p);wait();T:Teleport(pID,p)else function()T:TeleportToPlaceInstance(pID,jID,p)end end;if outsideData[1]['alwaysOn']then task.spawn(function()while true do if currentRevs>=outsideData[1]['revs']then r()end;currentRevs=currentRevs+1;task.wait(.01)end end)end print("TEM AUTO GRINDER STARTED\n\nThis will now run until you leave.")

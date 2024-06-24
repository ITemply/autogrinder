local outsideData  = {...}

local replicatedStorage = game:GetService('ReplicatedStorage')
local virtualUser = game:GetService('VirtualUser')
local players = game:GetService('Players')

local client = players.LocalPlayer

local damageEvent = replicatedStorage:WaitForChild('jdskhfsIIIllliiIIIdchgdIiIIIlIlIli')
local coinEvent = replicatedStorage:WaitForChild('Events'):WaitForChild('CoinEvent')

local NPCS = workspace:WaitForChild('NPC')

local jobId = game.JobId
local placeId = game.PlaceId

local revolutions = 0
local currentRevs = 0
local alwaysOn = true

local getKills = function(damageEvent)
	task.spawn(function()
		while true do
			for id, entity in ipairs(NPCS:GetChildren()) do
				if entity:FindFirstChild('Humanoid') then
					local s, e = pcall(function()
						local hitBoss = entity:FindFirstChild('Humanoid')

						local damageArgs = {
							[1] = hitBoss,
							[2] = 1
						}

						repeat
							damageEvent:FireServer(unpack(damageArgs))
							task.wait()
						until hitBoss.Health <= 0 or client.Character.Humanoid.Health <= 0
					end)
				end
			end
			task.wait(1)
		end
	end)
end

local getCoins = function(coinEvent)
	task.spawn(function()
		while true do
			coinEvent:FireServer()
			task.wait(0.5)
		end
	end)
end

local keepAlive = function()
	task.spawn(function()
		client.Idled:Connect(function()
			virtualUser:CaptureController()
			virtualUser:ClickButton2(Vector2.new())
		end)
	end)
end

local rejoin = function()
	if #players:GetPlayers() <= 1 then
		client:Kick('GAME REJOIN')
		wait()
		TeleportService:Teleport(placeId, client)
	else
		TeleportService:TeleportToPlaceInstance(placeId, jobId, client)
	end
end

local loadOutsideArgs = function(outsideArgs)
	task.spawn(function()
		alwaysOn = outsideArgs[1]['alwaysOn']
		revolutions = outsideArgs[1]['revs']
	end)
end

loadOutsideArgs(outsideData)

task.spawn(function()
	if alwaysOn then
		keepAlive()
		getKills(damageEvent)
		getCoins(coinEvent)
	else
		keepAlive()
		getKills(damageEvent)
		getCoins(coinEvent)
			
		task.spawn(function()
			while true do
				currentRevs = currentRevs + 1
				if currentRevs >= revolutions then
					rejoin()
				end
			end
		end)
	end
end)

print('TEM AUTO GRINDER STARTED\n\nThis will now run until you leave.')

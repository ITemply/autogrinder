local outsideData  = {...}

local replicatedStorage = game:GetService('ReplicatedStorage')
local virtualUser = game:GetService('VirtualUser')
local players = game:GetService('players')

local client = players.LocalPlayer

local damageEvent = replicatedStorage:WaitForChild('jdskhfsIIIllliiIIIdchgdIiIIIlIlIli')

local NPCS = workspace:WaitForChild('NPC')

local revolutions = 0
local alwaysOn = true

local getKills = function(damageEvent)
  task.spawn(function()
    while true do
      for id, entity in ipairs(NPCS:GetChildren()) do
        if entity:FindFirstChild('Humanoid') then
          local s, e = pcall(function()
            local hitBoss = entity:FindFirstChild('Humanoid')
            
            local local damageArgs = {
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

local keepAlive = function()
  client.Idled:Connect(function()
    virtualUser:CaptureController()
		virtualUser:ClickButton2(Vector2.new())
	end)
end

local loadOutsideArgs = function(outsideArgs)
	revolutions = outsideArgs[1]['revolutions']
	alwaysOn = outsideArgs[1]['alwaysOn']
end

loadOutsideArgs(outsideData)
keepAlive()
getKills()

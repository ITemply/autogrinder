<h1>Auto Grinder - AS</h1>
For scripted (exploited) clients only. 

Execute the code snip below into your executor and let the grinding happen.

```lua
local loadData = {
    ['revolutions'] = 10000000, -- how many times the bot will repeat before rejoining
    ['alwaysOn'] = true -- bypasses the setting above to constantly run (reccomended for client that don't lag)
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/ITemply/autogrinder/main/main.lua'))(loadData)
```

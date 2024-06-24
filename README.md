<h1>Auto Grinder - AS</h1>
For scripted (exploited) clients only. 

Execute the code snip below into your executor and let the grinding happen.

```lua
local loadData = {
    ['alwaysOn'] = true, -- bypasses the setting above to constantly run (reccomended for client that don't lag)
    ['revs'] = 10000000 -- the amount of times the script runs (counts by 0.01) seconds before rejoining
}

loadstring(game:HttpGet('https://raw.githubusercontent.com/ITemply/autogrinder/main/main.lua'))(loadData)
```

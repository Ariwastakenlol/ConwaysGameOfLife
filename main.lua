--The October Revolution
g = love.graphics
-----------------------------------

grid = {}   --making a grid
for x=0, 300 do
    grid[x] = {}
    for y=0, 300 do
        grid[x][y] = false
    end
end

function love.draw()    --drawing the grid
    for x,v in ipairs(grid) do
        for y,z in ipairs(grid[x]) do
            if grid[x][y] == false then
                g.setColor(0,1,0)
                g.circle('fill', x*5, y*5, 2)
            end
            if grid[x][y] == true then
                g.setColor(1,0,0)
                g.circle('fill', x*5, y*5, 2)
            end
        end
    end
end

function love.update(dt)
    
    for i=15,200 do 
        for y=15,200 do
            grid[i][y] = true
        end
    end
    
    if love.mouse.isDown() then
        grid[love.mouse.getX()][love.mouse.getY()] = true
    end
    
    for x=1 , 299 do
        for y=1 , 299 do
            bours = neighbourCalculator(x,y)
            if bours < 2 then                       -- first rule
                grid[x][y] = false
            elseif bours > 1 and bours < 4 then     -- second rule
                grid[x][y] = true
            elseif bours > 3 then                   -- third rule
                grid[x][y] = false
            elseif bours == 3 then                  --fourth rule
                grid[x][y] = true
            end
        end
    end
end

function neighbourCalculator(gx,gy)
    local neighbours = 0
    if grid[gx-1][gy] == true then neighbours = neighbours + 1      --left
    elseif grid[gx+1][gy] == true then neighbours = neighbours + 1  --right
    elseif grid[gx][gy-1] == true then neighbours = neighbours + 1  --upper
    elseif grid[gx-1][gy+1] == true then neighbours = neighbours + 1--lower
    elseif grid[gx-1][gy-1] == true then neighbours = neighbours + 1--left-upper
    elseif grid[gx-1][gy+1] == true then neighbours = neighbours + 1--left-lower
    elseif grid[gx+1][gy-1] == true then neighbours = neighbours + 1--right-upper
    elseif grid[gx+1][gy+1] == true then neighbours = neighbours + 1--right-lower
    end
    return neighbours
end
MORTO = false
VIVO  = true

local screenWidth = love.graphics.getWidth() -- 800
local screenHeight = love.graphics.getHeight() -- 600

function love.load()
    cellSize = 20
    cellDrawSize = cellSize - 1

    grid = {}
    gridXCount = screenWidth / cellSize
    gridYCount = screenHeight / cellSize

    for x = 1, gridXCount + 1 do
        grid[x] = {}
        for y = 1, gridYCount + 1 do
            grid[x][y] = MORTO
        end
    end

end

function love.update()
    mouseXLocation = math.floor(love.mouse.getX() / cellSize) + 1
    mouseYLocation = math.floor(love.mouse.getY() / cellSize) + 1

    if love.mouse.isDown(1) then
        grid[mouseXLocation][mouseYLocation] = VIVO
    end

    if love.mouse.isDown(2) then
        grid[mouseXLocation][mouseYLocation] = MORTO
    end
end


function love.draw()
    
    love.graphics.setColor(1,1,1)
    for y = 1, screenHeight / cellSize do
        for x = 1, screenWidth / cellSize do

            if grid[x][y] == VIVO then
                love.graphics.setColor(1,0,1)
            elseif x == mouseXLocation and y == mouseYLocation then
                love.graphics.setColor(0,.75,1)
            else
                love.graphics.setColor(1,1,1)
            end

            love.graphics.rectangle(
                'fill',
                (x - 1) * (cellSize),
                (y - 1) * (cellSize),
                cellDrawSize,
                cellDrawSize
            )
        end
    end
    love.graphics.setColor(0,0,0)
    love.graphics.print("O mouse esta em: " .. mouseXLocation .. ", " .. mouseYLocation)
end


function love.keypressed()

    nextGrid = {}
    nextGridXCount = screenWidth / cellSize
    nextGridYCount = screenHeight / cellSize

    for x = 1, nextGridXCount + 1 do
        nextGrid[x] = {}
        for y = 1, nextGridYCount + 1 do
            local neighbourCount = 0

            for dx = -1, 1 do
                for dy = -1, 1 do
                    if not (dy == 0 and dx == 0) and 
                    grid[x + dx] and 
                    grid[x + dx][y + dy] == VIVO then
                        neighbourCount = neighbourCount + 1
                    end
                end
            end

            nextGrid[x][y] = neighbourCount == 3 or (grid[x][y] and neighbourCount == 2)
            
        end
    end

    grid = nextGrid
end

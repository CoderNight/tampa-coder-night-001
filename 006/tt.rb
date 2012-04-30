
# just create a blank grid, for show, to get something going.
def cheaterGrid
  puts ". . . . . . . . . . .\n"*11
end

def printGridGeneric
  puts 'Generic C++Style'
  y = 0
  while y <= 11
    x = 0
    while x <= 11
      print '. '
      x += 1
    end
    puts ''
    y += 1
  end
end

def printGridGenericRubyStyle
  puts 'Generic RubyStyle'
  y = 0
  11.times do |y|
    x = 0
    11.times do |x|
      print '. '
      x += 1
    end
    puts ''
    y += 1
  end
end


def populateGridGeneric(grid)
  y = 0
  11.times do |y|
    x = 0
    11.times do |x|
      grid[x][y] = '. '
      x += 1
    end
    y += 1
  end
end

def printGrid(grid)
  y = 0
  11.times do |y|
    x = 0
    11.times do |x|
      print grid[x][y]
      x += 1
    end
    puts ''
    y += 1
  end
end

def stompOnCurrentSpot(grid, x, y)
  grid[x][y] = 'X '
  printGrid(grid)
end

def moveNorth(grid, currentX, currentY, num = 1)
  while (currentY <= 11)
    currentX += 1
  end
  stompOnCurrentSpot(grid, currentX, currentY)
end

def setCurrentSpot(grid, x, y)
  grid[x][y] = 'X '
end

### Definitions ###
# create a 2-D array.
rows, cols = 11,11
grid = Array.new(rows) { Array.new(cols) }
currentX = 5
currentY = 5
bearing = '0'


### Main Method ###
#populateGridGeneric(grid)
#populateGrid(grid)

stompOnCurrentSpot(grid, currentX, currentY)

#printGridGeneric
printGridGenericRubyStyle
#printGrid

#instruction = readInstruction(instructionFile)
#bearing = determineNewBearing(instruction)
#distance = determineDistance(instruction)
#walkTurtle(bearing, distance)




### Experimenting with Ruby 2-D array writes / reads. ###
=begin
puts ''
puts 'experimenting with 2D array'
grid[0][0] = 'a '
grid[0][2] = 'c '

puts grid[0][0]
puts grid[0][1]
puts grid[0][2]
=end

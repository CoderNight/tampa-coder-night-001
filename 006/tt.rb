
# just create a blank grid, for show, to get something going.
def printCheaterGrid
  puts "Cheater Grid"
  puts ( (". " *$gridSize) + "\n") *$gridSize
end

def printGridGeneric
  puts 'Generic C++Style'
  y = 0
  while y <= $gridSize
    x = 0
    while x <= $gridSize
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
  $gridSize.times do |y|
    x = 0
    $gridSize.times do |x|
      print $cellNotStompedUpon
      x += 1
    end
    puts ''
    y += 1
  end
end

def populateGrid
  y = 0
  $gridSize.times do |y|
    x = 0
    $gridSize.times do |x|
      $grid[x][y] = $cellNotStompedUpon
      x += 1
    end
    y += 1
  end
end

def printGrid
  y = 0
  $gridSize.times do |y|
    x = 0
    line = Array.new
    $gridSize.times do |x|
      #print $grid[x][y]
      line << $grid[x][y]
      x += 1
    end
    #print "\b"
    #puts ''
    #line.pop
    puts line.join('')
    y += 1
  end
end

def stompOnCurrentSpot
  $grid[$currentX][$currentY] = $cellStompedUpon
end

def moveEast(num = 1)
  num.times do 
    if ($currentX <= $gridSize)
      $currentX += 1
    end
  stompOnCurrentSpot
  end
end

def walkTurtle(cardinalDirection = 0, dist = 1, walkBackwards=FALSE)
#puts 'Method: Walk Turtle' #DEBUG
  if ( (cardinalDirection < 360) && (cardinalDirection % 45 == 0) )

    xy = $movementMatrix.assoc(cardinalDirection).last
    xDir = xy.first
    yDir = xy.last

    if walkBackwards == TRUE
      xDir = -xDir
      yDir = -yDir
    end

    dist.times do
      $currentX += xDir
      $currentY += yDir
      stompOnCurrentSpot
  end
  else failOut("The instructions contained an invalid rotation instruction value.")
  end
end

def loadTheInput
  inFile = Array.new
  STDIN.each_line do |line|
   inFile << line
  end

  if inFile.count < 3
    failOut("There seems to be a problem with the input; (the file seems too short).")
  end

  return inFile
end

def resetGridSize(instructionSet)
  if instructionSet[0].to_i.kind_of? Integer
    firstInstruction = instructionSet[0].to_i
  else failOut('The first line in the input should be an integer')
  end

  if firstInstruction % 2 == 1
    $gridSize = firstInstruction
  else failOut("The first instruction doesn't look like an odd number.  This is a problem.")
  end

  $currentX = $gridSize / 2
  $currentY = $gridSize / 2
end

def prepareInstructionSet(instructionSet)
  #remove first two lines of the instructionSet
  instructionSet.shift(2)

  # TODO: validate the rest of the file

  # create the instruction pointer
  $currentInstructionPointer = 0
end

def prepareRepeatedInstructionSet(repeatThisInstructionSet)
  workingArray = Array.new(repeatThisInstructionSet)
  
  if repeatThisInstructionSet.length % 2 == 1
    failOut("An instruction within a REPEAT block had an odd number of instructions.")
  end
  
  properArray = Array.new
  while workingArray.length > 0
    tmpArray = Array.new
    tmpArray << workingArray.shift
    tmpArray << workingArray.shift
    properArray << tmpArray.join(' ')
  end
  return properArray
end

def processInstructionSet(instructionSet)
#puts 'Method: Process Instruction Set' #DEBUG

  while instructionSet[$currentInstructionPointer]
    processOneInstruction(instructionSet)
    $currentInstructionPointer += 1
  end
end

def processOneInstruction(instructionSet)
#puts 'Method: Process One Instruction'  #DEBUG

  currentInstruction = instructionSet[$currentInstructionPointer].split(' ')
  
  if currentInstruction[0] == 'RT'
    #puts 'ROTATE' #DEBUG
    currentInstruction.shift

    #puts 'bearing before ' + $bearing.to_s #DEBUG
    rotation = currentInstruction[0].to_i
    if rotation % 45 != 0
      failOut("there's an invalid rotation value in the instruction. Looks like it's not a multiple of 45 degrees.")
    end

    $bearing += rotation
    if $bearing >=360
     $bearing -= 360
    end

    #puts 'bearing after ' + $bearing.to_s #DEBUG

  elsif currentInstruction[0] == 'LT'
    #puts 'ROTATE' #DEBUG
    currentInstruction.shift

    #puts 'bearing before ' + $bearing.to_s #DEBUG
    rotation = currentInstruction[0].to_i
    if rotation % 45 != 0
      failOut("there's an invalid rotation value in the instruction. Looks like it's not a multiple of 45 degrees.")
    end

    $bearing -= rotation
    if $bearing < 360
     $bearing += 360
    end

    #puts 'bearing after ' + $bearing.to_s #DEBUG

  elsif currentInstruction[0] == 'FD'
    #puts 'FORWARD' #DEBUG
    currentInstruction.shift
=begin
puts 'Forward distance: ' 
print currentInstruction[0].to_i
puts ''
=end

    dist = currentInstruction.pop.to_i
    #puts 'bearing = ' + $bearing.to_s #DEBUG
    #puts 'distance = ' + dist.to_s #DEBUG
    walkTurtle($bearing, dist)
#puts "End of FORWARD, after return from walkTurtle. the currentInstructionPointer is " + $currentInstructionPointer.to_s #DEBUG

  elsif currentInstruction[0] == 'BK'
    #puts 'BACKWARD' #DEBUG
    currentInstruction.shift
    dist = currentInstruction.pop.to_i
    puts 'bearing = ' + $bearing.to_s
    puts 'distance = ' + dist.to_s
    walkTurtle($bearing, dist, TRUE)

  elsif currentInstruction[0] == 'REPEAT'
    #puts 'REPEAT'  #DEBUG
    currentInstruction.shift
    repeatCount = currentInstruction[0].to_i
    currentInstruction.shift
    repeatThisInstructionSet = Array.new
    repeatThisInstructionSet = repeatThisInstructionSet + currentInstruction
    repeatThisInstructionSet.shift
    repeatThisInstructionSet.pop

    # prepare a couple things for running the neseted instructionSet recursively
    parkedInstructionPointer = $currentInstructionPointer
    repeatThisInstructionSet = prepareRepeatedInstructionSet(repeatThisInstructionSet)

    # 
    while repeatCount >= 1
#puts 'repeatCount => ' + repeatCount.to_s
#puts "In the whileLoop, about to run processInstructionSet on the nested. the currentInstructionPointer is " + $currentInstructionPointer.to_s
      $currentInstructionPointer = 0
      processInstructionSet(repeatThisInstructionSet)
      repeatCount -= 1
    end

#puts 'End of the REPEATed loop'

    $currentInstructionPointer = parkedInstructionPointer
#puts 'currentInstructionPointer' + $currentInstructionPointer.to_s

  else failOut("There's an unacceptable instruction in the input file." + currentInstruction[0])

  end

#puts "End of processOneInstruction.  the currentInstructionPointer is " + $currentInstructionPointer.to_s

end

def createMovementMatrix
  mtx = Array.new
  mtx << [0, [0, -1]]
  mtx << [45, [1, -1]]
  mtx << [90, [1, 0]]
  mtx << [135, [1, 1]]
  mtx << [180, [0, 1]]
  mtx << [225, [-1, 1]]
  mtx << [270, [-1, 0]]
  mtx << [315, [-1, -1]]
  mtx << [360, [0, -1]]
  return mtx
end

def failOut(reason)
  if $currentInstructionPointer != -1
    actualInstructionNumber = $currentInstructionPointer + 1 # because it's zero-indexed
    prefix = 'While processing instruction # ' + actualInstructionNumber.to_s + ": " 
  end

  puts prefix + reason #TODO: add line # reference in the failout 
  exit 1
end


### Definitions ###
# create a 2-D array.
$gridSize = 1001  #61 is a default
$cellNotStompedUpon = '. '
$cellStompedUpon = 'X '
rows, cols = $gridSize,$gridSize
$grid = Array.new(rows) { Array.new(cols) }
$currentX = $gridSize / 2 #sets a default
$currentY = $gridSize / 2 #sets a default
$bearing = 0
$movementMatrix = createMovementMatrix 
$currentInstructionPointer = -1 #sets a default

###
#
# Who needs Object Orientation, anyway?  I mean, come on, why use all that powerful, built-in Ruby goodness, when you can make it real complicated and hard to maintain?
#
# KIDDING.
#
# Oh, and Global Variables ROCK.
#
###

### Main Method ###
instructionSet = loadTheInput
resetGridSize(instructionSet)
prepareInstructionSet(instructionSet)
populateGrid

stompOnCurrentSpot

#printCheaterGrid
#printGridGeneric
#printGridGenericRubyStyle
#printGrid

#moveEast(5)

#Walk the Turtle manually from the code.
#walkTurtle(135, 7) #DEBUG
#walkTurtle(0, 20) #DEBUG
#walkTurtle(90, 15) #DEBUG

processInstructionSet(instructionSet)
=begin
#Do some manual InstructionFile Processing
processOneInstruction(instructionSet)
$currentInstructionPointer += 1
processOneInstruction(instructionSet)
$currentInstructionPointer += 1
processOneInstruction(instructionSet)
$currentInstructionPointer += 1
processOneInstruction(instructionSet)
$currentInstructionPointer += 1
processOneInstruction(instructionSet)
$currentInstructionPointer += 1
processOneInstruction(instructionSet)
=end
printGrid

#DEBUG
  #puts $currentX
  #puts $currentY




### Experimenting with file reading ###
#puts instructionSet


### Experimenting with Ruby 2-D array writes / reads. ###
=begin
puts ''
puts 'experimenting with 2D array'
gridArray[0][0] = 'a '
gridArray[0][2] = 'c '

puts gridArray[0][0]
puts gridArray[0][1]
puts gridArray[0][2]
=end

##
## Eighth Light, I know you're watching!  I will be the Last Starfighter!
## 
##

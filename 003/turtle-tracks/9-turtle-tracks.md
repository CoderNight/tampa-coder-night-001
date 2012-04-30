# [[#9] Turtle Tracks](http://puzzlenode.com/puzzles/9-turtle-tracks)

_This puzzle was contributed by Gregory Brown &amp; Andrea Singh and published on July 14, 2011_

Logo is a programming language created mainly for educational purposes in 1967. It is probably best known for [Turtle graphics](http://en.wikipedia.org/wiki/Turtle_graphics). These are drawings created using a on-screen cursor - often represented by a turtle icon - whose movements are controlled by a set of simple commands. 

The two main attributes of the turtle are position and orientation. Its movements are always relative to its current position, while the direction is determined by the turtle's orientation. For example, a command such as "forward 10" will move the turtle 10 units from its current position and in the facing direction. To make the turtle face in a different direction, you'd have to issue a command like "left 90". The number 90 refers to the angle that the turtle should pivot by, which in this case would be 90 degrees counterclockwise.

Your task is to write a Logo-like program that is capable of producing ASCII art. You will be provided with an input file containing a list of commands which when parsed and executed should produce an ASCII drawing. 

## The List of Commands

There is a small number of commands that you need to take into account:

- **FD x**: tells the turtle to move forward by x units
- **RT x**: change the turtle's current orientation by x degrees clockwise
- **LT x**: change the turtle's current orientation by x degrees counterclockwise
 
For simplicity's sake, in this exercise the angle of rotation will be restricted to multiples of 45. That is 45, 90, 135, etc.

- **BK x**: tells the turtle to move backwards by x units, keeping its current orientation
- **REPEAT x [...]**: tells the turtle to repeat the movements defined within the square brackets x times. You don't need to worry about handling nested `REPEAT` statements, since there won't be any in the input files.

## The Input Format

The input file consists of two parts: the canvas size that the drawing should be printed on and a list of Logo commands like the ones described in the previous section. The first line of the input file always indicates the canvas size followed by a blank line and then the list of commands.

The canvas is square, so the number specifying the canvas size refers to both the width and the height of the canvas. See below an example of an input file for an 11 x 11 canvas.

```
11

RT 90
FD 5
RT 135
FD 5
```

## The Output Format

The canvas can be thought of as a grid. Empty cells are represented by periods. Columns are separated by a space, while rows are separated by a new line.

As the turtle moves, each line segment is drawn by an `X` for each point the turtle has traveled across. The turtle is initially placed in the center of the grid and is facing upwards. That initial point should automatically be marked with an `X`, even before any commands are run.

So this would be the turtle on an 11 x 11 grid and in its starting position at the center point of the grid:

```
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
```

And here's the output after the simple input program has run.

```
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . . . . . . .
. . . . . X X X X X X
. . . . . . . . . X .
. . . . . . . . X . .
. . . . . . . X . . .
. . . . . . X . . . .
. . . . . X . . . . .
```

## Example

To get our turtle warmed up, we can set him the task of drawing the basic outline of our coat of arms - the Mendicant University logo! 

Here are the commands that will output the shape of a ruby gem when correctly executed:

```
61

RT 135
FD 5
REPEAT 2 [ RT 90 FD 15 ]
RT 90
FD 5
RT 45
FD 20
```

The first line tells us that our drawing pad is a 61 x 61 grid. We then place the turtle at the center point of the canvas facing upwards.

The first command issued to the turtle is to pivot by 135 degrees right or clockwise. It should then move 5 units forward. During that move it draws the first line. Looking at the current results, we should see something like this (Note that we zoomed in to the section of the grid right around the turtle):

```
. . X . . . . . . .
. . . X . . . . . .
. . . . X . . . . .
. . . . . X . . . .
. . . . . . X . . .
. . . . . . . X . .
```

The next command `REPEAT 2 [ Rt 90 Fd 15 ]` will tell the turtle to turn right by 90 degrees _and_ move forward 15 units two times in succession. Our output should look something like this:

```
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . X . . . . . . 
. . . . . . . . . . . . . . . . . . . . . . . . . . X . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . X . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . X . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . X . .
X . . . . . . . . . . . . . . . . . . . . . . . . . . . . . X .
. X . . . . . . . . . . . . . . . . . . . . . . . . . . . X . .
. . X . . . . . . . . . . . . . . . . . . . . . . . . . X . . .
. . . X . . . . . . . . . . . . . . . . . . . . . . . X . . . .
. . . . X . . . . . . . . . . . . . . . . . . . . . X . . . . .
. . . . . X . . . . . . . . . . . . . . . . . . . X . . . . . .
. . . . . . X . . . . . . . . . . . . . . . . . X . . . . . . .
. . . . . . . X . . . . . . . . . . . . . . . X . . . . . . . .
. . . . . . . . X . . . . . . . . . . . . . X . . . . . . . . .
. . . . . . . . . X . . . . . . . . . . . X . . . . . . . . . .
. . . . . . . . . . X . . . . . . . . . X . . . . . . . . . . .
. . . . . . . . . . . X . . . . . . . X . . . . . . . . . . . .
. . . . . . . . . . . . X . . . . . X . . . . . . . . . . . . .
. . . . . . . . . . . . . X . . . X . . . . . . . . . . . . . .
. . . . . . . . . . . . . . X . X . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . X . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
```

Then, we turn the turtle again by 90 degrees and walk forward 5:

```
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . X . . . . . . . . . . . . . . . . . . . X . . . . . .
. . . . X . . . . . . . . . . . . . . . . . . . . . X . . . . .
. . . X . . . . . . . . . . . . . . . . . . . . . . . X . . . .
. . X . . . . . . . . . . . . . . . . . . . . . . . . . X . . .
. X . . . . . . . . . . . . . . . . . . . . . . . . . . . X . .
X . . . . . . . . . . . . . . . . . . . . . . . . . . . . . X .
. X . . . . . . . . . . . . . . . . . . . . . . . . . . . X . .
. . X . . . . . . . . . . . . . . . . . . . . . . . . . X . . .
. . . X . . . . . . . . . . . . . . . . . . . . . . . X . . . .
. . . . X . . . . . . . . . . . . . . . . . . . . . X . . . . .
. . . . . X . . . . . . . . . . . . . . . . . . . X . . . . . .
. . . . . . X . . . . . . . . . . . . . . . . . X . . . . . . .
. . . . . . . X . . . . . . . . . . . . . . . X . . . . . . . .
. . . . . . . . X . . . . . . . . . . . . . X . . . . . . . . .
. . . . . . . . . X . . . . . . . . . . . X . . . . . . . . . .
. . . . . . . . . . X . . . . . . . . . X . . . . . . . . . . .
. . . . . . . . . . . X . . . . . . . X . . . . . . . . . . . .
. . . . . . . . . . . . X . . . . . X . . . . . . . . . . . . .
. . . . . . . . . . . . . X . . . X . . . . . . . . . . . . . .
. . . . . . . . . . . . . . X . X . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . X . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
```

Lastly, we finish the outline of the logo by turning yet again - this time only 45 degrees - and completing the line by moving 20 forward. The end result is the very familiar shape of the Mendicant University Ruby:

```
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
. . . . . . X X X X X X X X X X X X X X X X X X X X X . . . . . . 
. . . . . X . . . . . . . . . . . . . . . . . . . . . X . . . . . 
. . . . X . . . . . . . . . . . . . . . . . . . . . . . X . . . . 
. . . X . . . . . . . . . . . . . . . . . . . . . . . . . X . . . 
. . X . . . . . . . . . . . . . . . . . . . . . . . . . . . X . . 
. X . . . . . . . . . . . . . . . . . . . . . . . . . . . . . X . 
. . X . . . . . . . . . . . . . . . . . . . . . . . . . . . X . . 
. . . X . . . . . . . . . . . . . . . . . . . . . . . . . X . . . 
. . . . X . . . . . . . . . . . . . . . . . . . . . . . X . . . . 
. . . . . X . . . . . . . . . . . . . . . . . . . . . X . . . . . 
. . . . . . X . . . . . . . . . . . . . . . . . . . X . . . . . . 
. . . . . . . X . . . . . . . . . . . . . . . . . X . . . . . . . 
. . . . . . . . X . . . . . . . . . . . . . . . X . . . . . . . . 
. . . . . . . . . X . . . . . . . . . . . . . X . . . . . . . . . 
. . . . . . . . . . X . . . . . . . . . . . X . . . . . . . . . . 
. . . . . . . . . . . X . . . . . . . . . X . . . . . . . . . . . 
. . . . . . . . . . . . X . . . . . . . X . . . . . . . . . . . . 
. . . . . . . . . . . . . X . . . . . X . . . . . . . . . . . . . 
. . . . . . . . . . . . . . X . . . X . . . . . . . . . . . . . . 
. . . . . . . . . . . . . . . X . X . . . . . . . . . . . . . . . 
. . . . . . . . . . . . . . . . X . . . . . . . . . . . . . . . . 
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
```

To test-drive your code, you can use `simple.logo` as your input file and `simple_out.txt` as your output. For your final solution, please use `complex.logo` as the input.
# [[#9] Turtle Tracks](http://puzzlenode.com/puzzles/9-turtle-tracks)

#### Notes

Now that `Turtle` had a better interface for interacting with it, it really
felt wrong that `Turtle` was responsible for reading the input file since
`TurtleTracks` was already handling that step. So here I took that responsibility
out of `Turtle` and put it into `TurtleTracks`

## Usage

You can use this library to draw turtle tracks in code or via the command line.
To generate turtle tracks you'll need to supply an input file with the commands
to send to the turtle. You may also optionally pass the path for an output file
as the second argument. If no output path is given, it will default to
`turtle_out.txt`.

### Via Command Line

```
./turtle simple.logo <turtle_out.txt>
```

### Via Code

```
TurtleTracks.process(path_to_input, <path_to_output>)
```

### Controlling the Turtle manually

You can also control the turtle manually if you'd like for finer grained control.

```
commands = ["RT 90", "FD 2", "RT 90", "REPEAT 3 [ FD 5 RT 90 ]", "FD 2"]

turtle = Turtle.new(100)
turtle.process_commands(commands)
turtle.right(90)
turtle.forward(5)

output = File.open("turtle_out.txt", "w")
output.write(turtle.tracks)
```


# [[#9] Turtle Tracks](http://puzzlenode.com/puzzles/9-turtle-tracks)

#### Notes

Continuing on with my refactorings, I wanted the Turtle class to have a better
interface for interacting with it, so I made it respond to the input commands,
like `left`, `LT`, `right`, `RT`, etc. In the process, I tried to simplify the
logic for parsing the incoming commands.

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


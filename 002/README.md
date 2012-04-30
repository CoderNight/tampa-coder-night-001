# Coder Night - Turtle Assignment
### 2012-05-03
***

## Goal
Complete the assignment using only short methods (<= 3 lines).

## Result
It passes the test at [Puzzlenode](http://puzzlenode.com/puzzles/9-turtle-tracks). I enjoyed the challenge of keeping methods short but I wasn't entirely happy with the results. At least two methods were short by virtue of using ; within a line. The methods are pretty focused on doing one thing only but at the cost of some clarity.

## Notes
* Chose not to do a formal DSL because the instruction set of the language is
  so limited. 
* I worked first on the canvas, then points, then orientation, then movement.
  After that, implementing Logo was pretty simple. TDD FTW.
* My first attempt at Canvas.to_s worked (passed tests) but was extremely slow when doing the complex logo because it was creating an array of arrays then joining them all. Revised approach uses a hash keyed by the y axis and joins each line before >> to the string. Time dropped from "not finished after 3 minutes" to 0.238 seconds. If refactoring, I might make Canvas store points in this structure instead of using an array of arrays at all.
* Begs the question, is it worth it to have an explosion of the *number* of methods
  just to achieve *shorter* methods?

## Usage
cat some_file.logo | ruby turtle.rb

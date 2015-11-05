//Ryan Sullivan
//7-21-2015
//Bingo Lab
//New Beginnings
//The purpose of this program is to create a Bingo scorecard with five columns. The first column
//contains randomly generated numbers from 1 through 15. Each column to the right contains five new
//numbers with an increased minimum and maximum value by 15. However, the center square is a FREE space.

import "graphix" as g
import "math" as m
import "minitest" as t
def graphics = g.create(200, 300)

//Coordinates, letters and numbers for each bingo square
var x := 3
var y := 3
def bingoNumbers = list.empty
def bingoLetters = list.with("B","I","N","G","O")

//Creates a new column for each loop
//Started i at 0 to facilitate calculation of random numbers
for (0..4) do {i ->
    
    //Create five buttons in each column
    for (1..5) do { j ->
        
        //Generates a random number between 1 and 15 that is increased by (i*15)
        var newNumber := ((m.random * 15).rounded + (i*15)) + 1
        
        //Generates a new random number if a duplicate occurred
        while {bingoNumbers.contains(newNumber)} do {
            newNumber := ((m.random * 15).rounded + (i*15)) + 1
        }
        
        //Add the new number to the bingoNumbers list.
        bingoNumbers.add(newNumber)
        
        //Check for the square where "FREE" is added.
        if ((i == 2) && (j == 3)) then {
            def free = graphics.addButton.setText("FREE").setWidth(30).setHeight(30).at(x@y).draw
        } else {
            //In this case, the "size" attribute is used to obtain the number of the last item added to the list.
            graphics.addButton.setText("{bingoLetters.at(i+1)}"++"{bingoNumbers.at(bingoNumbers.size)}").setWidth(30).setHeight(30).at(x@y).draw
        }
        
        //Move down one space to start the next button in the column.
        y := y + 33
    }

    //Shift the x and y coordinates to start the next column in the card.
    x := x + 33
    y := 3
}

t.testSuite {
    t.test "button contains positive integer" by {
        t.assert (bingoNumbers.at(1) > 0)
        t.assert (bingoNumbers.at(25) > 0)
    }
    
    t.test "bingoNumber list size" by {
        t.assert (bingoNumbers.size) shouldBe 25
    }

    t.test "list contains positive integers" by {
        for (1..25) do {each ->
            t.assert(bingoNumbers.at(each) > 0)
        }
    }
    
}

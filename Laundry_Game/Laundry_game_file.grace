// New Beginnings - Lab 2
//
// Name: Ryan Sullivan
// Date: 7/15/15
// The purpose of this program is create a game that resembles sorting laundry into three stacks: whites, darks
// and colors. The central square randomly generates a color, and the user drags it into the correct pile.
// The game keeps score of correct and incorrect placements.

dialect "objectdraw"

inherits graphicApplication.size(400,400)

windowTitle := "Laundry Sorting"
def border = framedRect.at (0@0) size (canvas.width, canvas.height) on (canvas)

//Generic basket lengths and y-coordinates
def basketWidth = 80
def basketHeight = 80
def basketLocationY = 180
def basketLabelY = 210


//Laundry pile
def laundryLength = 40
def laundryLocation = (((canvas.width - laundryLength) / 2) @50)
def laundryFrame = framedRect.at(laundryLocation) size (laundryLength,laundryLength) on (canvas)
def laundryFill = filledRect.at(laundryLocation) size (laundryLength,laundryLength) on (canvas)


//Whites container
def whitesLocation = (40@basketLocationY)
def whitesLabelLocation = (50@basketLabelY)
def whites = framedRect.at(whitesLocation) size (basketWidth,basketHeight) on (canvas)
whites.color := color.r(150) g(150) b(150)
def whitesLabel = text.at(whitesLabelLocation) with ("whites") on (canvas)


//Darks container
def darksLocation = (160@basketLocationY)
def darksLabelLocation = (170@basketLabelY)
def darks = framedRect.at(darksLocation) size (basketWidth,basketHeight) on (canvas)
def darksLabel = text.at(darksLabelLocation) with ("darks") on (canvas)

//Colors container
def colorsLocation = (280@basketLocationY)
def colorsLabelLocation = (290@basketLabelY)
def colors = framedRect.at(colorsLocation) size (basketWidth,basketHeight) on (canvas)
colors.color := blue
def colorsLabel = text.at(colorsLabelLocation) with ("colors") on (canvas)

//Counter for correct and incorrect placements
var correctCount: Number := 0
var incorrectCount: Number := 0

//Text for correct placements
def correctText: Text = text.at(0@0) with ("Correct Placements: {correctCount}") on (canvas)
correctText.moveTo (((canvas.width - correctText.width) / 2) @ 300)
correctText.color := color.r(0) g(190) b(0)

//Text for incorrect placements
def incorrectText: Text = text.at (0@0) with ("Incorrect Placements: {incorrectCount}") on (canvas)
incorrectText.moveTo (((canvas.width - correctText.width) / 2) @ 320)
incorrectText.color := red

//Colors
var redNum : Number
var greenNum : Number
var blueNum : Number
var correctBasket : String

method assignColor {
    //Generate laundry color based on random integer
    redNum := randomIntFrom(0)to(255)
    greenNum := randomIntFrom(0)to(255)
    blueNum := randomIntFrom(0)to(255)
    laundryFill.color := color.r(redNum) g(greenNum) b(blueNum)
    
    if ((redNum + greenNum + blueNum) > 670) then {correctBasket := whites}
    elseif (((redNum + greenNum + blueNum) < 220) || (((redNum + greenNum) < 170) && (blueNum > 85))) then {correctBasket := darks} 
    else {correctBasket := colors}
    print "{correctBasket}"
    print "{redNum} {greenNum} {blueNum}"
    print "{redNum + greenNum + blueNum}"
}

//Beginning point for mouseDrag
var previousPosition : Point := (0@0)

//Record the mousePress coordinates in the previousPosition instance variable if within the laundryFill object
method onMousePress(pressPosition: Point) -> Done {
    if (laundryFrame.contains (pressPosition)) then {
        previousPosition := pressPosition
    }
}

//Move the laundryFill object to the current mouse position if the previousPosition's x-coordinate changed
method onMouseDrag(currentPosition: Point) -> Done {
    if (previousPosition.x > 0) then {
        laundryFrame.moveTo (currentPosition)
        laundryFill.moveTo (currentPosition)
    }
}

method onMouseRelease(releasePoint) {
    //Increase the correct count if the previousPosition's x-coordinate changed and the mouse is released over the colors object when the laundryFill is color.
    if ((previousPosition.x > 0) && (colors.contains(releasePoint)) && (correctBasket == colors)) then {
        
        correctCount := correctCount + 1
        correctText.contents := "Correct Placements: {correctCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
        assignColor
    }
    
    //Increase the incorrectCount if the colors container the releasePoint when laundryFill isn't colors
    if ((previousPosition.x > 0) && (colors.contains(releasePoint)) && (correctBasket != colors)) then {
        incorrectCount := incorrectCount + 1
        incorrectText.contents := "Incorrect Placements: {incorrectCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
    }
    
    //Increase the correct count if the previousPosition's x-coordinate changed and the mouse is released over the whites object when the laundryFill is white.
    if ((previousPosition.x > 0) && (whites.contains(releasePoint)) && (correctBasket == whites)) then {
        correctCount := correctCount + 1
        correctText.contents := "Correct Placements: {correctCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
        assignColor
    }
    
    //Increase the incorrectCount if the whites container the releasePoint when laundryFill isn't white
    if ((previousPosition.x > 0) && (whites.contains(releasePoint)) && (correctBasket != whites)) then {
        incorrectCount := incorrectCount + 1
        incorrectText.contents := "Incorrect Placements: {incorrectCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
    }
    
    //Increase the correct count if the previousPosition's x-coordinate changed and the mouse is released over the darks object when the laundryFill is dark.
    if ((previousPosition.x > 0) && (darks.contains(releasePoint)) && (correctBasket == darks)) then {
        correctCount := correctCount + 1
        correctText.contents := "Correct Placements: {correctCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
        assignColor
    }
    
    //Increase the incorrectCount if the darks container is the releasePoint when laundryFill isn't dark
    if ((previousPosition.x > 0) && (darks.contains(releasePoint)) && (correctBasket != darks)) then {
        incorrectCount := incorrectCount + 1
        incorrectText.contents := "Incorrect Placements: {incorrectCount}"
        laundryFrame.moveTo (laundryLocation)
        laundryFill.moveTo (laundryLocation)
        previousPosition := (0@0)
    }
    previousPosition := (0@0)
}

assignColor
startGraphics

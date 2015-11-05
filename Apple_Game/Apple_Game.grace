//Ryan Sullivan
//New Beginnings
//Apple Lab
//Date: 7-30-15

//The purpose of this program is to create a game similar to Hangman where the user guesses letters and the 
//game display shows whether the user correctly guessed a letter in a randomly generated word.
//The game ends when the user correctly guesses all letters in the word or the user runs out of guesses.

import "graphix" as graphix
import "math" as math

var graphics := graphix.create(200,700)
var randomWord : String

// GAME FACTORY
// Sets-ups and manages the game.

//ACTION: Design the interface for Game. 
//Game is responsible for choosing a new random word, and remembering the state of the game.
//When requested, it should tell the display how many letters are in the word, 
//and which letters to enter into the display boxes.   When requested, it should be able 
//to tell you whether the game is still in progress, and if not, who has won.
factory method createAppleGame(numberOfApples)  {
    
    //Creates new randomWord
    randomWord := wordList.atRandom
    print "{randomWord}"
    
    //Creates a set of letters contained in randomWord.
    def correctLetterSet is public = set.empty
    randomWord.do { ch ->
        correctLetterSet.add(ch)
    }
    print "{correctLetterSet}"
    
    //True while the game is in progress.
    var inProgress is public := true
    
    method isBadGuess(char) -> Boolean{
        //Note: This method isn't used. Its purpose is fulfilled without a separate method.
        // answers true if char has not been guessed before, and is not in the word.
        numberOfApples.badGuessSet.contains(numberOfApples.val).not
    }
    
    method wordSize -> Number {
        //Note: This method isn't used. Its purpose is fulfilled without a separate method.
        randomWord.size
    }
    
    method numberOfBadGuesses -> Number { 
        //Note: This method isn't used. Its purpose is fulfilled without a separate method.
        numberOfApples.badGuesses
    }
    
}


// GAMEDISPLAY FACTORY
// Draws the game display. Communicates with the game "g" to learn how many apples 
// are needed, how many letters are in the word, and when input is entered or 
// a button is clicked.

//ACTION: Implement the factory for GameDisplay factory:
//When a new GameDisplay is created, it should draw the correct number of apples, 
//randomly placed on the leaves of the tree. There should be a row of boxes 
//indicating the letters of the unknown word.  When a letter is entered in the input box, 
//the game display object should ask the Game object whether it is a Good or Bad guess.  
//When a correct letter is entered, the letter should appear in all of the appropriate 
//boxes. When an incorrect letter is entered, an apple should fall.   
//When a previously-guessed letter is entered, it should be ignored. 
//Optional: Display all the letters guessed.


def display = createDisplayForGame(createAppleGame(6))

factory method createDisplayForGame(g) {
    var letterBoxes := list.empty
    def goodGuessSet = set.empty
    
    //badGuesses keeps a count used for determining which apple should fall, when the
    //game should end and where letters incorrectly guessed should be positioned.
    //badGuessList contains the graphic labels for incorrect letters guessed.
    //badGuessSet is a set containing unique, incorrect letters guessed used for determining
    //when the input has been guessed before.
    var badGuesses is public := 0
    def badGuessList = list.empty
    def badGuessSet is public = set.empty
    
    
    //Create tree trunk, leaves, and apples
    def trunk is public = graphics.addRectangle.at((110@75)).setSize(40@325).colored "SaddleBrown".filled(true).draw
    def leaves is public = graphics.addEllipse.at((5@30)).setSize(250@140).colored "DarkGreen".filled(true).draw
    
    //Create six apples stored in a list.
    def appleList = list.empty
    (1..6).do { i ->
        appleList.add(createAppleAt((i*30+20)@((math.random * 95).truncated + 55)))
    }

    // ACTION: Create the row of boxes representing the randomWord.
    method letters {
        
        for (1..letterBoxes.size) do { i ->
            letterBoxes.removeAt(i)
        }
        for (1..randomWord.size) do { i -> 
            letterBoxes.add(graphics.addText().setContent("[__] ").at((i*20)@410).draw())
        }
        letterBoxes
    }
    letters
    
    //Creates the input box to enter guesses into.
    def inputBox = graphics.addInputBox().setWidth(40).at(80@450).draw()

    //This code runs when the input is entered into the box.
    inputBox.onSubmitDo {
        //Processes only the input's first character per turn.
        var val is public := inputBox.value.substringFrom(1)to(1).asLower
        
        //Print "Game Over" when badGuesses reaches 6.
        if (badGuesses >= 6) then {
            print("GAME OVER!")
            graphics.addText().setContent("GAME OVER!").at(90@10).draw()
            g.inProgress := false
        }
        
        //Print "Victory" when the characters added to th goodGuessSet.size matches 
        //the correctLetterSet.size based on the randomWord.
        elseif (goodGuessSet.size >= g.correctLetterSet.size) then {
            print("VICTORY!")
            graphics.addText().setContent("VICTORY!").at(90@10).draw()
            g.inProgress := false
        }
        //Checks if the letter has been guessed earlier in the game.
        elseif (badGuessSet.contains("{val.asUpper}")) then {return}
        elseif (goodGuessSet.contains("{val.asUpper}")) then {return}
        
        else {
            //foundPoint represents the index of the val in the randomWord.
            var foundPoint := randomWord.indexOf(val)
            
            //For correct guesses, adds letters to the boxes and the goodGuessSet.
            while { foundPoint != 0 } do {
                letterBoxes.at(foundPoint) put(letterBoxes.add(graphics.addText().setContent(" {val.asUpper} ").at((foundPoint*20)@410).draw()))
                foundPoint := randomWord.indexOf(val) startingAt(foundPoint + 1)
                goodGuessSet.add("{val.asUpper}")
            }
            //For incorrect guesses, adds letters for display in the badGuessList and
            //makes each apple fall.
            if (randomWord.contains(val).not) then {
                badGuesses := badGuesses + 1
                
                //"fall" is a method in the "Apple Factory"
                appleList[badGuesses].fall
                badGuessList.add(graphics.addText().setContent(" {val.asUpper} ").at((badGuesses*30+20)@432).draw())
                badGuessSet.add("{val.asUpper}")
                print "{badGuessSet}"
            }
        }
        
    }
    
    
    //New Game button
    def newGameButton = graphics.addButton().setText("New Game").setSize(75@33).at(10@450).draw()
    
    // ACTION: clears the graphics and requests the game to start over
    newGameButton.onClick := {
        graphics.clear
        createDisplayForGame(createAppleGame(6))
    }
}

// WORDLIST OBJECT
// Responsible for holding a list of valid words.  
// Has a method "atRandom" that returns a random one when requested.
method wordList {
    object {
        def words = list.with(
            "Apple", "Apricot", "Avocado", "Banana", "Bilberry", "Blackberry", 
            "Blackcurrant", "Blueberry", "Boysenberry", "Cantaloupe", "Currant", "Cherry", 
            "Cherimoya", "Cloudberry", "Coconut", "Cranberry", "Damson", "Date", 
            "Dragonfruit", "Durian", "Elderberry", "Feijoa", "Fig", "Grapefruit", "Guava", 
            "Huckleberry", "Jackfruit", "Kiwi", "Kumquat", "Lemon", "Lime", "Loquat", 
            "Lychee", "Mango", "Marionberry", "Melon", "Cantaloupe", "Honeydew", 
            "Watermelon", "Mulberry", "Nectarine", "Olive", "Orange", "Clementine", 
            "Mandarine", "Tangerine", "Papaya", "Passionfruit", "Peach", "Pear", 
            "Persimmon", "Physalis", "Plum", "Pineapple", "Pomegranate", "Pomelo", 
            "Mangosteen", "Quince", "Raspberry", "Salmonberry", "Raspberry", 
            "Rambutan", "Redcurrant", "Satsuma", "Starfruit", "Strawberry", "Tamarillo")
    
        method atRandom -> String {
          // returns one of the strings from in the list words, chosen at random.
          def index = (math.random * words.size).truncated + 1
          //made the words in lower case.
          words.at(index).asLower
        }

    }
} 

// Apple factory
// Draws an apple at point "p". The apple will fall when requested.
factory method createAppleAt(position) {
    def apple = graphics.addCircle.at(position).setRadius 10 
                    .colored "YellowGreen".filled(true).draw
    var applePath
    def fallAction = {
        if (applePath.isEmpty) then {
            graphics.clearTicker
        } else {
            apple.location := applePath.first
            apple.draw
            applePath.removeFirst
        }
    }
    
    method at(p) { apple.at(p) }
    method location { apple.location }
    method location:=(p) { apple.location := p }
    method draw { apple.draw }
    method asString { "an apple at {apple.location}"}
    
    method fall {
        applePath := fallPath
        graphics.tickEvent(fallAction, 20)
    }
    method fallPath is confidential {
        def duration = 500
        def path = list.empty
        def gravity = 0@2
        def damping = 0.5
        var initial := apple.location
        def ground = initial.x@390
        var tick := 0
        var p := initial
        while { p.y < ground.y } do {
            // the fall from rest to the ground
            // uses s = ut + (a.t^2)/2
            tick := tick + 1
            p := initial + (gravity * tick * tick / 2)
            path.addLast(p)
        }
        var v := gravity * tick
        repeat 5 times {
            def u = (0@0) - (v * damping)
            v := u
            tick := 0
            do {
                // the bounce:
                // uses s = ut + (a.t^2)/2 and v = u + at
                tick := tick + 1
                p := ground + (u * tick) + (gravity * tick * tick / 2)
                v := u + (gravity * tick)
                path.addLast(p)
            } while { p.y < ground.y }
        }
        path
    }
}

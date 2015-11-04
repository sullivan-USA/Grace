//Ryan Sullivan
//New Beginnings
//Pig Latin (Lab 4)
//7-23-2015

import "graphix" as g
import "gUnit" as gU

//Creates Pig Latin Converter Graphic
def graphics = g.create(200, 200)
def label = graphics.addText().setContent("Pig Latin Converter").at(0@10).draw()
def inputBox = graphics.addInputBox().setWidth(180).at(0@30).draw()
def encodeButton = graphics.addButton().setText("Encode").at(0@70).colored("lightblue").draw()
def decodeButton = graphics.addButton().setText("Decode").at(60@70).colored("lightgreen").draw()
def output = graphics.addText().at(0@100).setContent("").draw()

//Executes "encodeSentence" method when clicking the encodebutton.
encodeButton.onClick := {
    inputBox.value := encodeSentence(inputBox.value)
}

//Executes "decodeSentence" method when clicking the decodebutton.
decodeButton.onClick := {
    inputBox.value := decodeSentence(inputBox.value)
}

//Global variables
def vowels = list.with("a","e", "i", "o", "u")
var encodeString : String
var decodeString : String

//ACTION: Translate a sentence from English to Pig Latin.
//For words that begin with consonants, the initial consonant is moved to the end of the word
//and “ay” is added to the end.
//For words that begin with vowels, “yay” is added to the end of the word.
//Input text is "sentence"
method encodeSentence(sentence) {
    
    //The sentence is trimmed and a space is added to ensure that makeLatin Sentence works.
    makeLatinSentence(sentence.trim ++ " ")
    
    //encodeString appears in the text box and console.
    print "{encodeString.trim}"
    encodeString.trim
}


//Method to translate Engligh to Pig Latin and return as a string.
method makeLatinSentence (str:String) {
    var pigPrefix
    var pigSuffix
    var previousSpace := 0
    var currentSpace := str.indexOf" "
    encodeString := ""
    
    
    //The "while" loop keeps running while the foundPoint isn't zero
    //meaning that spaces are found in the string.
    //The sentence is parsed at each space into pig Latin prefixes and suffixes.
    while { (currentSpace != 0)} do {
        
        //If the word starts with a vowel, the prefix is the word, and the suffix is "yay"
        if (vowels.contains((str.at(previousSpace+1)).asLower)) then {
        
            pigPrefix := str.substringFrom(previousSpace+1)to(currentSpace - 1)
            pigSuffix := "yay"
        }
        else {
        //If the word doesn't start with a vowel, prefix is the word starting from the next index.
        //The suffix is the first letter plus "ay"
            pigPrefix := str.substringFrom(previousSpace + 2)to(currentSpace - 1)
            pigSuffix := ("{str.at(previousSpace + 1)}" ++ "ay")
        }
    
        //Move the currentSpace and previousSpace variables to the next spaces.
        previousSpace := currentSpace
        currentSpace := str.indexOf " " startingAt(currentSpace + 1)
    
        //Combine the prefix and suffix. Add to encodeString.
        //Note: Grace runs the remainder of the while loop after return condition is met.
        encodeString := encodeString ++ pigPrefix ++ pigSuffix ++ " "
    }
    //encodeString will be returned to the encodeSentence method.
    encodeString
}

//ACTION: Translate a sentence from Pig Latin to English.
method decodeSentence(sentence) {

    makeEnglishSentence(sentence.trim ++ " ")

    //decodeString appears in the textbox and console.
    print "{decodeString.trim}"
    decodeString.trim
}

//Method to convert Pig Latin to English and return as a string.
method makeEnglishSentence (str:String) {
    var englishWord
    var previousSpace := 0
    var currentSpace := str.indexOf" "
    decodeString := ""
    
    //The "while" loop keeps running while the foundPoint isn't zero
    //meaning that spaces are found in the string.
    //The sentence is parsed at each space into English words.
    while { (currentSpace != 0)} do {

        //If the word ends with "yay", remove that. 
        //If the word ends with "ay", remove that and move ending consonant to front.
        //Do not translate non-Pig Latin words.
        if (str.substringFrom(currentSpace-3)to(currentSpace-1).contains("yay")) then {
            englishWord := str.substringFrom(previousSpace+1)to(currentSpace-4)
        }
        elseif (str.substringFrom(currentSpace-2)to(currentSpace-1).contains("ay")) then {
            
            englishWord := str.at(currentSpace-3) ++ str.substringFrom(previousSpace+1)to(currentSpace-4)
        }
        else {englishWord := str.substringFrom(previousSpace+1)to(currentSpace-1)}
        
        //Move the currentSpace and previousSpace variables to the next spaces.
        previousSpace := currentSpace
        currentSpace := str.indexOf " " startingAt(currentSpace + 1)
    
        //Combine the prefix and suffix. Add to decodeString.
        //Note: Grace runs the remainder of the while loop after return condition is met.
        decodeString := decodeString ++ englishWord ++ " "
        
    }
    decodeString    
}

// TESTS

class encodeSentenceTest.forMethod(m) {
    inherits gU.testCaseNamed(m)
    method testStartingWithConstant {
            assert (encodeSentence "Javascript") shouldBe "avascriptJay"
    }
    method testStartingWithVowel {
            assert (encodeSentence "earth") shouldBe "earthyay"
    }
    method testManyWords {
            assert (encodeSentence "Javascript earth") shouldBe "avascriptJay earthyay"
    }
}

class decodeSentenceTest.forMethod(m) {
    inherits gU.testCaseNamed(m)
    method testStartingWithConstant {
            assert (decodeSentence "avascriptJay") shouldBe "Javascript"
    }
    method testStartingWithVowel {
            assert (decodeSentence "earthyay") shouldBe "earth"
    }
    method testNonPigLatin {
            assert (decodeSentence "cow") shouldBe "cow"
    }
    method testManyWords {
            assert (decodeSentence "avascriptJay earthyay cow") shouldBe "Javascript earth cow"
    }
}

print("Testing encodeSentence")
gU.testSuite.fromTestMethodsIn(encodeSentenceTest).runAndPrintResults
print("Testing decodeSentence")
gU.testSuite.fromTestMethodsIn(decodeSentenceTest).runAndPrintResults

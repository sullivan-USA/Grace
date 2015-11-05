//Ryan Sullivan
//New Beginnings
//Linked List Lab
//8-13-2015

//The purpose of this program is to test whether the Linked_List_Implementation.grace file produces the expected
//results.

dialect "minitest"
import "math" as math
import "unicode" as unicode
import "linkedListLab" as ListFile

//NEW TESTS


//The variables in the iterator reset each time the object is called. 
//This list stores the iterator in a variable. Calling only the method on this list will
//avoid resetting the variables.


var word1 := "Iceman"
var word2 := "cinema"
var word3 := "icicle"

//List needs to reset for each test.
method resetList {}

testSuiteNamed "Lab tests" with {
    var numList := ListFile.with(22, 11, 44, 33)
    var iteratorList := ListFile.with(12, 8, 20)
    
    test "simple iterator" by {
        var out := ""
        for (numList) do { each -> out := "{out} {each}"}
        assert (out) shouldBe " 22 11 44 33"
    }
    
    test "two iterators" by {
        def iter1 = numList.iterator
        def iter2 = numList.iterator
        repeat 2 times { iter1.next }
        assert(iter1.next) shouldBe 44
        assert(iter2.next) shouldBe 22
    }
    
    test "reversed" by {
        assert (numList.reversed.asString) shouldBe "[33, 44, 11, 22]" 
    }
    test "addFirst" by {
        numList.addFirst(1)
        assert (numList.asString) shouldBe "[1, 22, 11, 44, 33]" 
    }
    test "add" by {
        resetList
        numList.add(99)
        assert (numList.asString) shouldBe "[22, 11, 44, 33, 99]"
    }
    test "size" by {
        resetList
        assert (numList.size) shouldBe 4
    }
    test "selectionSort" by {
        resetList
        numList.selectionSort
        assert (numList.asString) shouldBe "[44, 33, 22, 11]"
    }
    test "anagrams" by {
        assert (ListFile.empty.anagram(word1)and(word2)) shouldBe (true)
        assert (ListFile.empty.anagram(word1)and(word3)) shouldBe (false)
        assert (ListFile.empty.anagram(word3)and(word2)) shouldBe (false)
    }
    test "square to binary conversion" by {
        assert (ListFile.empty.squareBinary(1).asString) shouldBe ("[1]")
        assert (ListFile.empty.squareBinary(2).asString) shouldBe ("[0, 1]")
        assert (ListFile.empty.squareBinary(4).asString) shouldBe ("[0, 0, 1]")
        assert (ListFile.empty.squareBinary(8).asString) shouldBe ("[0, 0, 0, 1]")
    }
    test "integer to binary conversion" by {
        assert (ListFile.empty.asBinary(3).asString) shouldBe ("[1, 1]")
        assert (ListFile.empty.asBinary(5).asString) shouldBe ("[1, 0, 1]")
        assert (ListFile.empty.asBinary(8).asString) shouldBe ("[0, 0, 0, 1]")
        assert (ListFile.empty.asBinary(10).asString) shouldBe ("[0, 1, 0, 1]")
        assert (ListFile.empty.asBinary(ListFile.with(0, 1, 0, 1).asNumber).asString) shouldBe ("[0, 1, 0, 1]")
    }
    test "binary to integer conversion" by {
        assert (ListFile.empty.asBinary(10).asNumber) shouldBe 10
        assert (ListFile.with(0, 1, 0, 1).asNumber) shouldBe 10
        assert (ListFile.with(1, 0, 1).asNumber) shouldBe 5
        assert (ListFile.with(1, 1).asNumber) shouldBe 3
    }
    test "sum of binary numbers" by {
        assert ((ListFile.empty.sumBinary(ListFile.with(1, 0, 1))and(ListFile.with(0, 1, 0, 1))).asString)
            shouldBe "[1, 1, 1, 1]"
        assert (ListFile.empty.sumBinary(ListFile.empty.asBinary(20))and(ListFile.empty.asBinary(4)))
            shouldBe (ListFile.empty.asBinary(24))
        assert ((ListFile.empty.sumBinary(ListFile.empty.asBinary(16))and(ListFile.empty.asBinary(14))).asNumber)
            shouldBe 30
        assert ((ListFile.empty.sumBinary(ListFile.empty.asBinary(6))and(ListFile.empty.asBinary(30))).asNumber)
            shouldBe 36
    }
    test "contains" by {
        resetList
        assert (numList.contains(22)) shouldBe (true)
        assert (numList.contains(33)) shouldBe (true)
        assert (numList.contains(82)) shouldBe (false)
    }
    test "list at index" by {
        resetList
        assert (numList.at(1)) shouldBe 22
        assert (numList.at(4)) shouldBe 33
    }
    test "iterator - next" by {
        def testIterator = iteratorList.iterator
        assert (testIterator.next) shouldBe 12
        assert (testIterator.next) shouldBe 8
        assert (testIterator.next) shouldBe 20
    }
    test "iterator - hasNext" by {
        def testIterator = iteratorList.iterator
        assert (testIterator.hasNext) shouldBe (true)
        assert (testIterator.next) shouldBe 12
        assert (testIterator.hasNext) shouldBe (true)
        assert (testIterator.next) shouldBe 8
        assert (testIterator.hasNext) shouldBe (true)
        assert (testIterator.next) shouldBe 20
        assert (testIterator.hasNext) shouldBe (false)
    }
}



//EXISTING TESTS

//testSuiteNamed "List tests" with {
//    test "empty size" by {
//        assert (ListFile.empty.size) shouldBe 0
//    }
//    
//    test "empty do" by {
//        ListFile.empty.do { each -> failBecause "empty.do did!" }
//        assert (true)
//    }
//    
//    test "empty asDebugString" by {
//        assert (ListFile.empty.asDebugString) shouldBe "⏚"
//    }
//    
//    test "empty asString" by {
//        assert (ListFile.empty.asString) shouldBe "[]"
//    }
//
//    def numbers = ListFile.empty.add 36 .add 15 .add 52 .add 23
//    
//    test "numbers size" by {
//        assert (numbers.size) shouldBe 4
//    }
//    
//    test "numbers do" by {
//        var s := ""
//        numbers.do { each ->  s := s ++ each ++ " "}
//        assert (s) shouldBe "36 15 52 23 "
//    }
//    
//    test "numbers asDebugString" by {
//        assert (numbers.asDebugString) shouldBe "36|15|52|23|⏚"
//    }
//    
//    test "numbers asString" by {
//        assert (numbers.asString) shouldBe "[36, 15, 52, 23]"
//    }
//
//    def revNumbers = ListFile.empty.addFirst 36 .addFirst 15 .addFirst 52 .addFirst 23
//    
//    test "revNumbers size" by {
//        assert (revNumbers.size) shouldBe 4
//    }
//    
//    test "revNumbers do" by {
//        var s := ""
//        revNumbers.do { each ->  s := s ++ each ++ " "}
//        assert (s) shouldBe "23 52 15 36 "
//    }
//    
//    test "revNumbers asDebugString" by {
//        assert (revNumbers.asDebugString) shouldBe "23|52|15|36|⏚"
//    }
//
//    def sorted = ListFile.empty.add 15 .add 23 .add 36 .add 52
//    
//    test "insert after 36" by {
//        def nodeWith36 = sorted.search 36 ifAbsent{ failBecause "36 not found" }
//        nodeWith36.insert 12
//        assert(sorted.asDebugString) shouldBe "15|23|36|12|52|⏚"
//    }
//    
//    test "insert first then last" by {
//        def lst47 = ListFile.empty.addFirst 4.add 7
//        assert(lst47.asDebugString) shouldBe "4|7|⏚"
//    }
//    
//    
//    test "search for absent" by {
//        var blockExecuted := false
//        numbers.search 12 ifAbsent { blockExecuted := true }
//        assert (blockExecuted) description 
//            "searching for 12 did not execute the ifAbsent action"
//    }
//
//    test "insert one in order" by {
//        def insertionValue = 27
//        def nodePreceeding = sorted.searchSuchThat { x -> x > insertionValue }
//        nodePreceeding.insert(insertionValue)
//        assert(sorted.asDebugString) shouldBe "15|23|27|36|52|⏚"
//    }
//    
//    test "insert many in order" by {
//        def input = list.empty
//        repeat 50 times {
//            input.add((math.random*100).truncated)
//        }
//        def result = ListFile.empty
//        input.do{ each -> result.addInPlace(each) }
//        input.sort
//        result.do { each -> 
//            assert(each) shouldBe (input.first)
//            input.removeFirst
//        }
//    }
//    
//    test "deletion" by {
//        assert(sorted.delete(23) ifAbsent {
//            failBecause "23 wsan't found"
//        }) shouldBe (list.with(15, 36, 52))
//    }
//    
//    test "delete from sigleton" by {
//        assert(ListFile.with(20).delete(20) ifAbsent{}) shouldBe (ListFile.empty)
//    }
//    
//    test "delete but not there" by {
//        var absent := false
//        sorted.delete(20) ifAbsent { absent := true }
//        assert(absent) description "20 wasn't absent"
//    }
//    
//    test "delete from empty" by {
//        var absent := false
//        ListFile.empty.delete(20) ifAbsent { absent := true }
//        assert(absent) description "20 wasn't ab sent from empty list"
//    }
//}
//
//testSuiteNamed "Equality tests" with {
//    
//    def one = ListFile.empty.add 1
//
//    test "empty" by {
//        assert(ListFile.empty) shouldBe (ListFile.empty)
//        assert(ListFile.empty) shouldntBe (one)
//        assert(one) shouldntBe (ListFile.empty)
//    }
//    
//    test "one element" by {
//        def one' = ListFile.with(1)
//        assert(one) shouldBe(one')
//        assert(one) shouldntBe (ListFile.with 2)
//    }
//    
//    test "three elements" by {
//        def l123 = ListFile.with(1, 2, 3)
//        assert(l123) shouldBe (ListFile.with(1, 2, 3))
//        assert(l123) shouldntBe (ListFile.with(1, 2, 1))
//        assert(l123) shouldntBe (ListFile.empty)
//        assert(l123) shouldntBe (ListFile.with(1, 2))
//        assert(l123) shouldntBe (ListFile.with(1, 2, 3, 4))
//    }
//}
//
////PALINDROMES
//
//method asLower(ch) {
//    // Grace's C string library lacks case conversions.  This method
//    // returns the lower-case version of the first character of ch
//    
//    if (ch < "A" ) then { return ch }
//    if (ch > "Z" ) then { return ch }
//    def caseOffset = "A".ord - "a".ord
//    return unicode.create(ch.ord - caseOffset)
//}
//
//method isPalindrome(phrase:String) {
//    // tests phrase to see if it is a palindrome.  Capitalization, spaces
//    // and puctuation are ignored.
//    def input = ListFile.empty
//    phrase.do { ch -> 
//        def l = asLower(ch)
//        if ((l ≥ "a") && (l ≤ "z")) then {
//            input.add(l)
//        } 
//    }
//    input == input.reversed
//}
//
//
//testSuiteNamed "Palindrome tests" with {
//    def phrase1 = "A Toyota"
//    def phrase2 = "Damn Mad!"
//    def phrase3 = "A man, a plan, a canal: Panama."
//    def phrase4 = "compare, but don't moc."
//    
//    test "asLower a" by {
//        assert (asLower "a") shouldBe "a"
//    }
//    test "asLower Q" by {
//        assert (asLower "Q") shouldBe "q"
//    }
//    test "asLower A" by {
//        assert (asLower "A") shouldBe "a"
//    }
//    test "asLower @" by {
//        assert (asLower "@") shouldBe "@"
//    }
//    test "asLower empty" by {
//        assert (asLower "") shouldBe ""
//    }
//
//    test "simple palindromes" by {
//        assert (isPalindrome "") description "the empty string is not a palindrome"
//        assert (isPalindrome "a") description "the string \"a\" is not a palindrome"
//    }
//    
//    test "interesting palindromes" by {
//        assert (isPalindrome(phrase1)) description "phrase1 is not a palindrome"
//        assert (isPalindrome(phrase2)) description "phrase2 is not a palindrome"
//        assert (isPalindrome(phrase3)) description "phrase3 is not a palindrome"
//    }
//    
//    test "non-palindromes" by {
//        deny (isPalindrome("ab")) description "\"ab\" is a palindrome"
//        deny (isPalindrome(phrase4)) description "phrase4 is a palindrome"
//    }
//}

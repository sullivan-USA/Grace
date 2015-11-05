//Ryan Sullivan
//New Beginnings
//Linked List Lab
//8-13-2015

//The purpose of this program is to implement linked lists as a data structure. Specific objectives are 
//described in the Linked_List_Purpose.adoc file.


import "math" as math
import "unicode" as unicode

//Same effect as list.with() but for linked lists.
method with(*a) {
    def result = empty
    a.do { each -> result.add(each) }
    return result
}

//Creates an empty linked list object.
factory method empty {
    
    //Creates a node.
    factory method node(d, n) {
        
        //The data in the node.
        var data is public := d
        
        //The next node in the list.
        var next is public := n
        
        //returns the whole linked list as a string because "next" retrieves the subsequent
        //node.
        method asString { "{data}|{next}" }
        
        //Replaces the "data" part of the node with the value passed to it.
        method insert(value) {
            next := node(value, next)
        }
    }
    
    //null is the last item in the linked list.
    def null = Singleton.named "⏚"
    
    //top is the first item in the linked list.
    def top = node("header", null)
    
    var lastNode := top

    factory method iterator {
        var currentElement := top.next
        method next {
            def result = currentElement.data
            currentElement := currentElement.next
            result
        }
        
        //"hasNext" returns a boolean for whether data exists in the next node.
        method hasNext {
            currentElement != null
        }
    }
    
    //"next" returns the next data
    
    
    //Same as "at()" for a contiguous list
    method at(index) {
        var counter := 0
        self.do {each ->
            counter := counter + 1
            if (index == counter) then {return each}
        }
        ProgrammingError.raise "Index out of bounds"
    }
    
    //Almost the same as "contains" for a contiguous list.
    method contains (needle) {
        
        self.do {each ->
            if (each == needle) then {
                return true
            }
        }
        return false
    }
    
    //Takes as input two binary number lists and returns a new list 
    //containing their sum, represented in the same way.  
    method sumBinary(firstBinary)and(secondBinary) {
        var sumInteger := (firstBinary.asNumber) + (secondBinary.asNumber)
        var sumBinary := asBinary(sumInteger)
        sumBinary
    }
    
    //Takes as input a list containing 0s and 1s. 
    //Returns the number that the bits represent.
    method asNumber {
        var exponent := 0
        var result := 0
        
        self.do {each ->
            result := result + (each * (2^exponent))
            exponent := exponent + 1
        }
        result
    }
    
    //Takes as input an integer n, and converts n to binary.  The method should return 
    //a linked list with the least significant bit of the binary representation of n at 
    //the head (left) of the list, and the most significant bit at the tail (right).  
    method asBinary (integer) {
        def resultList = empty
        var multiple := integer
        var remainder : Number
        
        while {multiple != 0} do {
            multiple := multiple/2
            remainder := (multiple - multiple.truncated)*2
            resultList.add(remainder)
            multiple := multiple.truncated
        }
        resultList
    }

    //Converts square integers to binary
    method squareBinary (square) {
        def resultList = empty
        var input := square
        var exponent := 0
        
        while {input > 1} do {
            input := input/2
            exponent := exponent + 1
            resultList.add(0)
        }
        resultList.add(1)
        if ((square - (2^exponent)) == 0) then {return resultList}
        else {ProgrammingError.raise "Not a square"}
    }

    method asLower(ch) {
        // Grace's C string library lacks case conversions.  This method
        // returns the lower-case version of the first character of ch
        
        if (ch < "A" ) then { return ch }
        if (ch > "Z" ) then { return ch }
        def caseOffset = "A".ord - "a".ord
        return unicode.create(ch.ord - caseOffset)
    }

    //Sorts a linked list from largest to smallest. 
    method selectionSort {
        
        var largest
        var counter := 0
        def resultList = empty
        
        //The while loop stops when counter = (self.size - 1) because the last node 
        //contains a hidden null value. Adding the last value from self into the resultList
        //would override the whole resultList. Thus, I had to add the resultList back into
        //self.
        while {counter <= self.size} do {
            largest := top.next.data
            self.do { each ->
                if (each > largest) then {largest := each}
            }
            self.delete(largest) ifAbsent { return}
            resultList.addFirst(largest)
            counter := counter + 1
        }
        resultList.do {each ->
            self.addFirst(each)
        }
        self
    }
    
    //Use your selectionSort method to check if two words are anagrams of each other.
    method anagram(firstWord)and(secondWord) {
        def firstList = empty
        def secondList = empty
        
        //firstWord and firstList
        firstWord.do { ch -> 
            firstList.add(ch.asLower)
        }
        firstList.selectionSort
        
        //secondWord and secondList
        secondWord.do {ch ->
            secondList.add(ch.asLower)
        }
        secondList.selectionSort

        firstList == secondList
    }
    
    // Returns a new list, containing my elements in reverse order.
    //The list that we reverse is the empty object.
    method reversed {
        
        //Cycles through the list adding each item to the top. This will restack the
        //items in reversed order.
        def result = empty
        self.do { each -> result.addFirst(each) }
        return result
    }

    // returns the number of elements in self
    method size {
        
        var result := 0
        
        //the "current" variable is set to the "top" variable.
        var current := top
        
        //"next" returns the next element of the collection. The loop checks whether each
        //element in current is not equal to null and adds incrementally to the
        //"result" variable. "result" is returned with the number of elements or "size".
        while { current.next ≠ null } do {
            current := current.next
            result := result + 1
        }
        return result
    }
    
    // applies action to each element of self
    method do(action:Block1) {
        
        var current := top
        
        //"next" returns the next element of the collection. The loop checks whether each
        //element in current is not equal to null and applies the action passed to the 
        //method on the node's current data.
        while { current.next ≠ null } do {
            current := current.next
            action.apply(current.data)
        }
    }
    
    // searches for needle in self.  Returns the first node
    // containing needle if it is found; otherwise, applies action.
    method search(needle) ifAbsent(action) {
        
        var current := top
        
        //"next" returns the next element of the collection. The loop checks whether each
        //element in current is not equal to null and checks whether the current element
        //matches the "needle". The node that matches the needle is returned; otherwise,
        //the action passed is applied.
        while { current.next ≠ null } do {
            current := current.next
            if (needle == current.data) then { return current }
        }
        action.apply
    }
    
    // Searches self for data for which predicate holds.
    // Returns the node PRECEEDING the node containing that data,
    // if it exists, otherwise returns my last node.
    //Does predicate.apply mean whether true or false applies to the data?
    //I have seen predicates in the form of { x -> x == value }
    method searchSuchThat(predicate) {
        
        var current := top
        while { current.next ≠ null } do {
            if (predicate.apply(current.next.data)) then { return current }
            current := current.next
        }
        return current
    }
    
    // returns a string representation of self suitable for debugging
    method asDebugString {
        
        //"top" is the first node and "next" iterates over the remaining nodes.
        top.next.asDebugString
    }
    
    // returns a string representation of self suitable for clients
    //The list printed asString is the empty object.
    method asString {
        
        var result := "["
        
        //The first variable is used to put a starting bracket around the first element.
        var first := true
        do { each ->
            if (first) then {
                result := "[" ++ each
                first := false
            } else {
                result := result ++ ", " ++ each
            }
        }
        result ++ "]"
    }
    
    // adds value to the end of self.  Returns self (modified)
    //lastNode is a variable that was set to "top".
    method add(value) {
        
        //creates a new node after lastNode and assigns it as the new lastNode.
        lastNode.next := node(value, null)
        lastNode := lastNode.next
        return self
    }
    
    // adds value to the start of self.  Returns self (modified)
    method addFirst(value) {
        
        //adds a new node after the top node. 
        //lastNode is changed to the next node if it was at the top.
        top.next := node(value, top.next)
        if (lastNode == top) then { lastNode := top.next }
        return self
    }
    
    // adds value to self in the place preceeding the first
    // element > value.  Returns self (modified)
    //Why is "searchSuchThat" not using parentheses as a method typically does?
    method addInPlace(value) {
        
        //"nodePreceeding" is determined using the "searchSuchThat" method.
        //Inserts a value in nodePreceeding?
        def nodePreceeding = searchSuchThat { x -> x > value }
        nodePreceeding.insert(value)
        return self
    }
    
    // returns the last node in self
    method findLastNode {
        
        //sets the "current" variable to the top of the list.
        var current := top
        
        //"next" returns the next element of the collection. The loop checks whether each
        //element in current is not equal to null and sets "current" to that element.
        //"current" is returned as the last node.
        while { current.next ≠ null } do {
            current := current.next
        }
        return current
    }
    
    // Deletes the first node containing value, if there is one.
    // Otherwise, executes action.
    method delete(value) ifAbsent(action) {
    
        //Applies "action" passed if "nodePreceeding" yields "null" result.
        //Otherwise, sets the node after nodePreceeding to the next node. This should
        //skip the "deleted" node from being chosen next in the linked list.
        def nodePreceeding = searchSuchThat { x -> x == value }
        if (nodePreceeding.next == null) then { return action.apply }
        nodePreceeding.next := nodePreceeding.next.next
        return self
    }
    
    //checks whether two items are equal.
    method == (other) {
        
        //Sets the "current" variable to the node after the top.
        //For each item in "other", "current" returns false if equal to null or the data
        //in current does not equal the item in other.
        //The "current" variable is changed to the next node after each loop.
        var current := top.next
        other.do { that -> 
            if (current == null) then { return false }
                // because other has an element, and self does not
            if (current.data ≠ that) then { return false }
            current := current.next
        }
        
        //Returns curret equal to null if current equaled each item in "other".
        //Does current == null return true if it matched each item in "other" without 
        //additional elements?
        return (current == null)
            // because if current ≠ null, then self has additional elements
    }
}

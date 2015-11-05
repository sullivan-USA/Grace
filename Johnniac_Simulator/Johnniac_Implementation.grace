//Ryan Sullivan
//Johnniac Machine Simulator
//8-11-2015

//The purpose of this program is simulate a Johnniac Machine. It performs basic computations and stores values
//in memory.

//Syntax: 
//OPCODE [2 digits] 
//OPERAND [3 digits]

//Instruction Set:
//#   00   HALT – Stop Execution
//#   01   LOAD – Put c(Operand) into Acc
//#   02   STORE – Put c(Acc) into the Operand Loc 
//#   03   ADD – Add c(Operand) to c(Acc), result in Acc
//#   04   MULTIPLY - Multiply c(Operand) by c(Acc), result in Acc
//#   05   DIVIDE - Divide c(Operand) by c(Acc), result in Acc
//#   06   SUBTRACT - Subtract c(Operand) from c(Acc), result in Acc
//#   07   TEST – if c(Acc) is not zero, continue execution at Operand
//#   08   GET – take 5 digit number from keyboard and place into Operand
//#   09   PUT – display c(Operand) on screen
//#   10   NOOP – dummy operation

def hub = object {
    var programCounter := 0
    
    //Answers programCounter number
    method count {programCounter}
    
    //Resets programCounter to zero
    method resetCount {programCounter := 0}
    
    method decode (submitList) {
    //Reads the first two digits (opcode) of each list item and passes the remaining 
    //three digits as a Number to the appropriate method.
        
        submitList.do { row ->
            //Increase programCounter for each iteration.
            programCounter := programCounter + 1
            
            //00   HALT – Stop Execution
            if (row.substringFrom(1)to(2) == "00") then {
                print "programCounter = {programCounter} \naccumulator = {cumulativeValue}"
                return
            }
            
            //Initiates LOAD
            if (row.substringFrom(1)to(2) == "01") then {
                accumulator.load(row.substringFrom(3)to(5).asNumber)
            }
            
            //Initiates STORE
            elseif (row.substringFrom(1)to(2) == "02") then {
                memory.store(row.substringFrom(3)to(5).asNumber)
            }
            
            //Initiates ADD
            elseif (row.substringFrom(1)to(2) == "03") then {
                accumulator.add(row.substringFrom(3)to(5).asNumber)
            }
            
            //Initiates MULTIPLY
            elseif (row.substringFrom(1)to(2) == "04") then {
                accumulator.multiply(row.substringFrom(3)to(5).asNumber)
            }
            
            //Initiates DIVIDE
            elseif (row.substringFrom(1)to(2) == "05") then {
                accumulator.divide(row.substringFrom(3)to(5).asNumber)
            }
            
            //Initiates SUBTRACT
            elseif (row.substringFrom(1)to(2) == "06") then {
                accumulator.subtract(row.substringFrom(3)to(5).asNumber)
            }
            
            //07   TEST – if c(Acc) is not zero, continue execution at Operand
            elseif ((row.substringFrom(1)to(2) == "07") && (cumulativeValue != 0)) then {}
            
            elseif ((row.substringFrom(1)to(2) == "07") && (cumulativeValue == 0)) then {
                print "programCounter = {programCounter} \naccumulator = {cumulativeValue}"
                return
            }
            
            
            //08   GET – take 5 digit number from keyboard and place into Operand
            elseif (row.substringFrom(1)to(2) == "08") then {
                memory.get(row.substringFrom(3)to(5).asNumber)
            }
            
            //09   PUT – display c(Operand) on screen
            elseif (row.substringFrom(1)to(2) == "09") then {
                print "{row.substringFrom(3)to(5)}"
            }
            
            //10   NOOP – dummy operation
            elseif (row.substringFrom(1)to(2) == "10") then {
                print "opcode 10"
            }
            
            //Raise error when the opcode is invalid.
            else {ProgrammingError.raise "Invalid opcode"}
        }
        print "programCounter = {programCounter} \naccumulator = {cumulativeValue}"
    }
}

//The accumulator's value is global because access is needed in all objects.
var cumulativeValue := 0

def accumulator = object {
    
    //Answers the accumulator's value
    method value {cumulativeValue}
    
    method load (operand) {
    //01   LOAD – Put c(Operand) into Acc
        cumulativeValue := operand
        cumulativeValue
    }
    method add (operand) {
    //03   ADD – Add c(Operand) to c(Acc), result in Acc
        cumulativeValue := operand + cumulativeValue
        cumulativeValue
    }
    method multiply (operand) {
    //04   MULTIPLY - Multiply c(Operand) by c(Acc), result in Acc
        cumulativeValue := operand * cumulativeValue
        cumulativeValue
    }
    method divide (operand) {
    //05   DIVIDE - Divide c(Operand) by c(Acc), result in Acc
        if (accumulator == 0) then {ProgrammingError.raise "Division by 0 is undefined"}
        else {
            cumulativeValue := operand / cumulativeValue
            cumulativeValue
        }
    }
    method subtract (operand) {
    //06   SUBTRACT - Subtract c(Operand) from c(Acc), result in Acc
        cumulativeValue := cumulativeValue - operand
        cumulativeValue
    }
}

def memory = object {
    
    //Create a list of blank memory slots from 1 to 999.
    def memoryList = (1..999).map{ each -> 0}.asList
    
    //Answers the value at a memory location
    method value (location) {memoryList.at(location)}
    
    //02   STORE – Put c(Acc) into the Operand Loc 
    method store (operLoc) {
        memoryList.at(operLoc)put(cumulativeValue)   
        memoryList.at(operLoc)
    }
    
    //08   GET – take 5 digit number from keyboard and place into Operand
    method get (operLoc) {
        memoryList.at(operLoc)put(operLoc)   
        memoryList.at(operLoc)
    }
}

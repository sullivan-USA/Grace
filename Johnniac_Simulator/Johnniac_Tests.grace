//Ryan Sullivan
//Johnniac Machine Simulator
//8-11-2015

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

dialect "minitest"
import "johnniac" as johnniac

method resetObjects {
//Resets programCounter and accumulator to zero.
    johnniac.hub.resetCount
    johnniac.accumulator.load(0)
}

testSuite {
    
    test "load operands" by {
        assert(johnniac.accumulator.load(333)) shouldBe 333
        assert(johnniac.accumulator.load(101)) shouldBe 101
    }
    test "store one operand" by {
        johnniac.accumulator.load(333)
        assert(johnniac.memory.store(150)) shouldBe 333
    }
    test "add operands" by {
        resetObjects
        assert(johnniac.accumulator.add(200)) shouldBe 200
        assert(johnniac.accumulator.add(200)) shouldBe 400
    }
    test "multiply operands" by {
        resetObjects
        assert(johnniac.accumulator.multiply(200)) shouldBe 0
        johnniac.accumulator.load(10)
        assert(johnniac.accumulator.multiply(5)) shouldBe 50
    }
    test "divide operands" by {
        johnniac.accumulator.load(5)
        assert(johnniac.accumulator.divide(200)) shouldBe 40
        johnniac.accumulator.load(1)
        assert(johnniac.accumulator.multiply(50)) shouldBe 50
    }
    test "subtract operands" by {
        johnniac.accumulator.load(100)
        assert(johnniac.accumulator.subtract(20)) shouldBe 80
        assert(johnniac.accumulator.subtract(80)) shouldBe 0
    }
    test "get operands" by {
        assert(johnniac.memory.get(150)) shouldBe 150
        assert(johnniac.memory.get(555)) shouldBe 555
    }
    test "end-to-end 1" by {
        resetObjects
        print "end-to-end 1"
        johnniac.hub.decode(list.with("01011", "02990", "03014", "04002", "05250", "06004", "07558", 
            "08444", "09133", "10566"))
        assert(johnniac.hub.count) shouldBe 10
        assert(johnniac.accumulator.value) shouldBe 1
        assert(johnniac.memory.value(990)) shouldBe 11
        assert(johnniac.memory.value(444)) shouldBe 444
    }
    test "end-to-end 2" by {
        resetObjects
        print "\nend-to-end 2"
        johnniac.hub.decode(list.with("01055", "02662", "03025", "05800", "06010", "07558",
            "08432"))
        assert(johnniac.hub.count) shouldBe 6
        assert(johnniac.accumulator.value) shouldBe 0
        assert(johnniac.memory.value(662)) shouldBe 55
        assert(johnniac.memory.value(432)) shouldBe 0
    }
    test "end-to-end 3" by {
        resetObjects
        print "\nend-to-end 3"
        johnniac.hub.decode(list.with("01123", "02456", "00222", "10321"))
        assert(johnniac.hub.count) shouldBe 3
        assert(johnniac.accumulator.value) shouldBe 123
        assert(johnniac.memory.value(456)) shouldBe 123
    }
}

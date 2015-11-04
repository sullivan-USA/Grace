//Ryan Sullivan
//New Beginnings
//Book Catalog Lab
//Date: 7-28-15

dialect "minitest"
import "bookLab" as bookFile
//imports the bookLab file for using the newBook method of creating book objects.

testSuite {
    def book1 = bookFile.newBook.bookAuthor "Scott Doorley" bookTitle "Make Space" 
        bookPublisher "Wiley" bookYear 2011
    def listQuery1 = list.with("Scott", "Make")
    def listQuery2 = list.with("Not", "Here")
    def listQuery3 = list.with("Scott", "None")
    def stringQuery1 = "Space"
    def stringQuery2 = "Nothing"
    
//Book Tests
    test "author retrieval" by {
        assert (book1.bookAuthor) shouldBe "Scott Doorley"
    }    
    
    test "title retrieval" by {
        assert (book1.bookTitle) shouldBe "Make Space"
    }
    
    test "publisher retrieval" by {
        assert (book1.bookPublisher) shouldBe "Wiley"
    }
    
    test "year retrieval" by {
        assert (book1.bookYear) shouldBe 2011
    }
    
//Keyword and Phrase Tests
    test "containsAllKeywords - both" by {
        assert (book1.containsAllKeywords(listQuery1)) shouldBe (true)
    }
    
    test "containsAllKeywords - none" by {
        assert (book1.containsAllKeywords(listQuery2)) shouldBe (false)
    }
    
    test "containsAllKeywords - one" by {
        assert (book1.containsAllKeywords(listQuery3)) shouldBe (false)
    }
    
    test "containsAnyKeywords - one" by {
        assert (book1.containsAnyKeywords(listQuery3)) shouldBe (true)
    }
    
    test "containsAnyKeywords - none" by {
        assert (book1.containsAnyKeywords(listQuery2)) shouldBe (false)
    }

    test "containsPhrase - true" by {
        assert (book1.containsPhrase(stringQuery1)) shouldBe (true)
    }    
    
    test "containsPhrase - false" by {
        assert (book1.containsPhrase(stringQuery2)) shouldBe (false)
    }    
}

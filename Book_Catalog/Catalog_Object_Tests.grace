//Ryan Sullivan
//New Beginnings
//Book Catalog Lab
//Date: 7-28-15

dialect "minitest"
import "bookLab" as bookFile
import "catalogLab" as catalogFile

testSuite {
    //Created catalogs here and passed them to the catalogLab methods.
    def catalog = list.empty
    def catalogBookData = catalogFile.newCatalog.addBookData(list.empty)
    def book1 = bookFile.newBook.bookAuthor "Scott Doorley" bookTitle "Make Space" 
        bookPublisher "Wiley" bookYear 2011
    def listQuery1 = list.with("Warren", "Approximate")
    def listQuery2 = list.with("Nothing", "Approximate")
    def listQuery3 = list.with("Andrew", "Example")
    def listQuery4 = list.with("Nothing", "Nothing")
    def stringQuery1 = "Andrew"
    def stringQuery2 = "Nothing"
    
//Catalog Tests
    test "catalog add one book" by {
        catalogFile.newCatalog.addTo(catalog) book(book1)
        assert (catalog[1].bookAuthor) shouldBe "Scott Doorley"
        assert (catalog[1].bookTitle) shouldBe "Make Space"
        assert (catalog[1].bookPublisher) shouldBe "Wiley"
        assert (catalog[1].bookYear) shouldBe 2011
    }  
    test "catalog add a list of books" by {
        catalogFile.newCatalog.addBookData(catalog)
        assert (catalog[10].bookAuthor) shouldBe "R.C. Holt"
        assert (catalog[10].bookTitle) shouldBe "Concurrent Euclid, The Unix System, and Tunis"
        assert (catalog[10].bookPublisher) shouldBe "Addison-Wesley"
        assert (catalog[10].bookYear) shouldBe 1983
    }
    test "catalog remove" by {
        catalogFile.newCatalog.addTo(catalog) book(book1)
        assert (catalogFile.newCatalog.removeFrom(catalog) book(book1)) shouldBe (true)
    }
    
//Keyword and Phrase Tests
//Note: The "bookList" variables are created from different methods depending on the test. 
    test "containsAllKeywords - one result" by {
        var bookList := catalogFile.newCatalog.containsAllKeywords(catalogBookData) search(listQuery1)
        assert (bookList[1]) shouldBe (catalogBookData[6])
    }  
    test "containsAllKeywords - no result" by {
        var bookList := catalogFile.newCatalog.containsAllKeywords(catalogBookData) search(listQuery2)
        assert (bookList.asString) shouldBe ("[]")
    } 
    test "containsAllKeywords - two results" by {
        var bookList := catalogFile.newCatalog.containsAllKeywords(catalogBookData) search(listQuery3)
        assert (bookList[1]) shouldBe (catalogBookData[2])
        assert (bookList[2]) shouldBe (catalogBookData[36])
    }  
    test "containsAnyKeywords - two results" by {
        var bookList := catalogFile.newCatalog.containsAnyKeywords(catalogBookData) search(listQuery2)
        assert (bookList[1]) shouldBe (catalogBookData[6])
        assert (bookList[2]) shouldBe (catalogBookData[7])
    }
    test "containsAnyKeywords - no results" by {
        var bookList := catalogFile.newCatalog.containsAnyKeywords(catalogBookData) search(listQuery4)
        assert (bookList.asString) shouldBe ("[]")
    }  
    test "containsPhrase - two results" by {
        var bookList := catalogFile.newCatalog.containsPhrase(catalogBookData) search(stringQuery1)
        assert (bookList[1]) shouldBe (catalogBookData[2])
        assert (bookList[2]) shouldBe (catalogBookData[36])
    }  
    test "containsPhrase - no results" by {
        var bookList := catalogFile.newCatalog.containsPhrase(catalogBookData) search(stringQuery2)
        assert (bookList.asString) shouldBe ("[]")
    }  
}

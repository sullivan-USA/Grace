//Ryan Sullivan
//New Beginnings
//Book Catalog Lab
//Date: 7-28-15

//The purpose of this program is to create catalog objects similar to a catalog of books. 
//Books created via the Book_Object.grace file can be added or removed from the catalog.

import "bookData" as bookData
import "bookLab" as bookFile

method newCatalog {
//Designs a book catalog object to which you can add and remove individual books.
    
    object {
        method asString {"the catalog class"}
        
        method addTo(catalog:List) book(new) -> Done {
        // Adds a new book to the catalog
            catalog.add(new)
        }
        
        method addBookData (catalog) {
        //Adds each book from "bookData" to the catalog in a "do" loop 
        //using the "addTo()book()" method.
            bookData.data.do { item ->
                addTo(catalog) book (bookFile.newBook.bookAuthor "{item[1]}" bookTitle "{item[2]}"
                    bookPublisher ("{item[3]}") bookYear (item[4]))
            }
            catalog
        }
        
        method removeFrom(catalog) book(old) -> Boolean {
        // If "old" is in this catalogue, removes it and returns true, otherwise returns false.
            if (catalog.contains(old)) then {
                catalog.remove(old)
                return true
            } else {false}
        }
        
        method containsAllKeywords (catalog) search(query:List<String>) {
        // Returns a list of the books that contain all of the query list's strings 
        // in their author or title
            def bookList = list.empty
            var matches := 0
            //"matches" counts the number of query strings that were contained in the
            // book's author or title.

            catalog.do { book ->
                query.do { keyword ->
                    if (book.bookAuthor.contains(keyword) || book.bookTitle.contains (keyword)) then {
                           matches := matches + 1 
                    }
                }
                if (query.size == matches) then {bookList.add(book)}
                //Adds the book to the bookList of all the query strings were contained
                // in either the book's author or title. Reset matches to zero before
                //  counting matches for each new query string. 
                matches := 0
            }
            bookList
        }
        
        method containsAnyKeywords (catalog) search(query:List<String>) {
        // answers a list of the books that contain any one of the Strings in 
        // the query list in their author or title
            def bookList = list.empty
            catalog.do { book ->
                query.do { keyword ->
                    if (book.bookAuthor.contains(keyword) || book.bookTitle.contains (keyword)) then {
                        bookList.add(book)
                    }
                }
            }
            bookList
        }
        
        method containsPhrase (catalog) search (query:String) {
        // answers a list of the books that contain the query as a substring of the author or title
            def bookList = list.empty
            catalog.do {book ->
                if (book.bookAuthor.contains(query) || book.bookTitle.contains (query)) then {
                    bookList.add(book)
                }
            }
            bookList
        }
        
    }
}

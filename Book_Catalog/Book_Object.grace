//Ryan Sullivan
//New Beginnings
//Book Catalog Lab
//Date: 7-28-15

//The purpose of this program is to create a book object similar to a book. Multiple book objects can be stored
//in a catalog object, which is created via the Catalog_Object.grace file.

method newBook {
//Define an object book that has two methods: an asString method that answers 
//the String “the book class” and a method that answers a new (immutable) book object.

    object {
        //The "asString" method contains the message that appears for tracing compiler errors.
        method asString {"the book class"}
        
        method bookAuthor(author:String) bookTitle(title:String) 
            bookPublisher(publisher:String) bookYear(year:Number) {
            object  {
                method asString {"\"{title}\", {author} ({publisher}, {year})"}
    
                method bookAuthor {author}
                //answers the newBook's author
                
                method bookTitle {title}
                //answers the newBook's title
                
                method bookPublisher {publisher}
                //answers the newBook's publisher
                
                method bookYear {year}
                //answers the newBook's year
                
                method containsAllKeywords(query:List<String>) -> Boolean {
                //answers "true" if all of the Strings in the query list are present 
                //in the newBook's author or title
                    
                    //"keyword" represents each string in the query list
                    query.do { keyword ->
                        if (author.contains(keyword) || title.contains(keyword)) then {}
                             else {return false}
                    }
                    true
                }
                
                method containsAnyKeywords(query:List<String>) -> Boolean {
                // answers "true" if any one of the Strings in the query list 
                //are present in the newBook's author or title
                    
                    query.do { keyword ->
                        if (author.contains(keyword) || title.contains(keyword)) then {
                            return true
                        }
                    }
                    false
                }
                
                method containsPhrase(query:String) -> Boolean {
                // answers true if the newBook's author or title contains the query
                //string as a substring.
                    author.contains(query) || title.contains(query)
                }
            }
        }
    }
}

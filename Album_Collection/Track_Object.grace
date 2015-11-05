//Ryan Sullivan
//New Beginnings
//Album Collection Lab
//Date: 8-6-15

//The purpose of this program is to create track objects similar to tracks on a music album.
//Track objects can be added or removed from album objects created through the Album_Object.grace file.

factory method newTrack {
//Define an object track that has two methods: an asString method that answers 
//the String “the track class” and a method that answers a new (immutable) track object.

    //The "asString" method contains the message that appears for tracing compiler errors.
    method asString {"the track class"}
    
    factory method trackArtist (artist:String) trackTitle(title:String) 
        trackYear (year:Number) {
 
        method asString {"\"{title}\" {artist} ({year})"}
        
        // answers my artist(s) — the musicians playing this track
        method trackArtist {artist}
        
        // answers my title
        method trackTitle {title}
        
        // answers the year in which this track was recorded
        method trackYear {year}
        
        method containsAllKeywords(query:List<String>) -> Boolean {
        //answers "true" if all of the Strings in the query list are present 
        //in the newTrack's artist or title
            
            //"keyword" represents each string in the query list
            query.do { keyword ->
                if (artist.contains(keyword) || title.contains(keyword)) then {}
                     else {return false}
            }
            true
        }
        
        method containsAnyKeywords(query:List<String>) -> Boolean {
        // answers "true" if any one of the Strings in the query list 
        //are present in the newTrack's artist or title
            
            query.do { keyword ->
                if (artist.contains(keyword) || title.contains(keyword)) then {
                    return true
                }
            }
            false
        }
        
        method containsPhrase(query:String) -> Boolean {
        // answers true if the newTrack's artist or title contains the query
        //string as a substring.
            artist.contains(query) || title.contains(query)
        }
    }
}

//Note: Creating the type Track is only useful if you want to put the catalog and
//test methods in the same file.

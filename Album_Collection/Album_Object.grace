//Ryan Sullivan
//New Beginnings
//Album Collection Lab
//Date: 8-6-15

//The purpose of this file is create album objects similar to a music album. 
//Track objects, which are created through the Track_Objects.grace file, can be added or removed from album objects.

factory method newAlbum {
//Designs an album object to which you can add and remove individual tracks.
    
    method asString {"the album class"}
    
    factory method albumTitle (title:String) albumArtist(artist:String) 
        albumTracks (trackList) {
 
        method asString {"\"{title}\" {artist} ({albumTracks})"}
        
        // the title of this album
        method albumTitle {title}
        
        // the name of the artist (the band, orchestra, or soloist)
        method albumArtist {artist}
        
        // answers my tracks
        method albumTracks {trackList}
    }
    method addTo(trackList) track(new) -> Done {
        // Adds a new track to the album's trackList
            trackList.add(new)
    }
    method removeFrom(trackList) track(old) -> Boolean {
        // If "old" is in this album's trackList, removes it and returns true, 
        // otherwise returns false.
        if (trackList.contains(old)) then {
            trackList.remove(old)
            return true
        } else {false}
    }
    
    method containsAllKeywords (albumTrackList) search(query:List<String>) {
    // Returns a list of the tracks that contain all of the query list's strings 
    // in their artist or title
        def trackMatchList = list.empty
        var matches := 0
        //"matches" counts the number of query strings that were contained in the
        // track's artist or title.

        albumTrackList.do { track ->
            query.do { keyword ->
                if (track.trackArtist.contains(keyword) || track.trackTitle.contains (keyword)) then {
                       matches := matches + 1 
                }
            }
            if (query.size == matches) then {trackMatchList.add(track)}
            //Adds the track to the trackMatchList of all the query strings were contained
            // in either the track's artist or title. Reset matches variable to zero before
            //  counting matches for each new query string. 
            matches := 0
        }
        trackMatchList
    }
    method containsAnyKeywords (albumTrackList) search(query:List<String>) {
    // answers a list of the tracks that contain any one of the Strings in 
    // the query list in their artist or title
        def trackMatchList = list.empty
        albumTrackList.do { track ->
            query.do { keyword ->
                if (track.trackArtist.contains(keyword) || track.trackTitle.contains (keyword)) then {
                    trackMatchList.add(track)
                }
            }
        }
        trackMatchList
    }
    method containsPhrase (albumTrackList) search (query:String) {
    // answers a list of the books that contain the query as a substring of the author or title
        def trackMatchList = list.empty
        albumTrackList.do {track ->
            if (track.trackArtist.contains(query) || track.trackTitle.contains (query)) then {
                trackMatchList.add(track)
            }
        }
        trackMatchList
    }
}        

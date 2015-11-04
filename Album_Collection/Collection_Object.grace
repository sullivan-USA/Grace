//Ryan Sullivan
//New Beginnings
//Album Collection Lab
//Date: 8-6-15

import "albumLab" as albumFile
import "trackLab" as trackFile

factory method newAlbumCollection {
//Designs an album collection object to which you can add and remove individual albums.
    
    method asString {"the album collection class"}
    
    method albums (albumList) {albumList}
        // answers my albums

    method addTo(albumList) album(new) -> Done {
        // Adds a new album to the albumList
        albumList.add(new)
    }
    
    method addMusicData(dataFile) collection(albumList) {
    //Adds each album from dataFile to the albumList in a "do" loop 
    //using the "addTo()album()" method.
        dataFile.do { album ->
            addTo(albumList) album (albumFile.newAlbum.albumTitle "{album[2]}" 
                albumArtist "{album[1]}" albumTracks (list.with(
                    trackFile.newTrack.trackArtist "{album[1]}" trackTitle "{album[4]}" trackYear "{album[3]}")))
        }
        albumList
    }

    method removeFrom(albumList) track(old) -> Boolean {
        // If "old" is in this collection's albumList, removes it and returns true, 
        // otherwise returns false.
        if (albumList.contains(old)) then {
            albumList.remove(old)
            return true
        } else {false}
    }
}        

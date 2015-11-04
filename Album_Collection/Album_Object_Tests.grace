//Ryan Sullivan
//New Beginnings
//Album Collection Lab
//Date: 8-6-15

dialect "minitest"
import "albumLab" as albumFile
import "trackLab" as trackFile

testSuite {
    //Created album here and passed them to the albumLab methods.
    def album1 = albumFile.newAlbum.albumTitle "Atmospheres" albumArtist "Deuter"
        albumTracks (list.with( 
            (trackFile.newTrack.trackArtist "Deuter1" trackTitle "Uno" trackYear 1991), 
            (trackFile.newTrack.trackArtist "Deuter2" trackTitle "Deux" trackYear 1992),
            (trackFile.newTrack.trackArtist "Deuter3" trackTitle "Drei" trackYear 1993),
            (trackFile.newTrack.trackArtist "Deuter4" trackTitle "Four" trackYear 1994),
            (trackFile.newTrack.trackArtist "Deuter" trackTitle "Cinque 1" trackYear 1995),
            (trackFile.newTrack.trackArtist "Deuter" trackTitle "Cinque 2" trackYear 1995),
            (trackFile.newTrack.trackArtist "Deuter4" trackTitle "Sieben" trackYear 1997)
            ))
    def track8 = (trackFile.newTrack.trackArtist "Deuter8" trackTitle "Huit" trackYear 1998)
    def listQuery1 = list.with("Deuter3", "Drei")
    def listQuery2 = list.with("Nothing", "Nothing")
    def listQuery3 = list.with("Deuter", "Cinque")
    def listQuery4 = list.with("Cinque", "Nothing")
    def stringQuery1 = "Deuter4"
    def stringQuery2 = "Nothing"
    
//Album Tests
    test "title retrieval" by {
        assert (album1.albumTitle) shouldBe "Atmospheres"
    }
    test "artist retrieval" by {
        assert (album1.albumArtist) shouldBe "Deuter"
    }
    test "track retrieval" by {
        assert (album1.albumTracks[2].asString) shouldBe "\"Deux\" Deuter2 (1992)"
    }
    test "track artist retrieval" by {
        assert (album1.albumTracks[1].trackArtist) shouldBe "Deuter1"
    }
    test "track title retrieval" by {
        assert (album1.albumTracks[2].trackTitle) shouldBe "Deux"
    }
    test "track year retrieval" by {
        assert (album1.albumTracks[3].trackYear) shouldBe 1993
    }
//Add and Remove tests
    test "add new track" by {
        albumFile.newAlbum.addTo(album1.albumTracks) track (track8)
        assert (album1.albumTracks[8].asString) shouldBe "\"Huit\" Deuter8 (1998)"
        assert (album1.albumTracks[8].trackArtist) shouldBe "Deuter8"
        assert (album1.albumTracks[8].trackTitle) shouldBe "Huit"
        assert (album1.albumTracks[8].trackYear) shouldBe 1998
    }
    test "remove old track" by {
        albumFile.newAlbum.addTo(album1.albumTracks) track(track8)
        assert (albumFile.newAlbum.removeFrom(album1.albumTracks) track(track8)) shouldBe (true)
    }
    
//Keyword and Phrase Tests
//Note: The "trackMatchList" variables are created from different methods using different queries.
    test "containsAllKeywords - one result" by {
        var trackMatchList := albumFile.newAlbum.containsAllKeywords(album1.albumTracks) search(listQuery1)
        assert (trackMatchList[1]) shouldBe (album1.albumTracks[3])
    }  
    test "containsAllKeywords - no result" by {
        var trackMatchList := albumFile.newAlbum.containsAllKeywords(album1.albumTracks) search(listQuery2)
        assert (trackMatchList.asString) shouldBe ("[]")
    } 
    test "containsAllKeywords - two results" by {
        var trackMatchList := albumFile.newAlbum.containsAllKeywords(album1.albumTracks) search(listQuery3)
        assert (trackMatchList[1]) shouldBe (album1.albumTracks[5])
        assert (trackMatchList[2]) shouldBe (album1.albumTracks[6])
    }  
    test "containsAnyKeywords - two results" by {
        var trackMatchList := albumFile.newAlbum.containsAnyKeywords(album1.albumTracks) search(listQuery4)
        assert (trackMatchList[1]) shouldBe (album1.albumTracks[5])
        assert (trackMatchList[2]) shouldBe (album1.albumTracks[6])
    }
    test "containsAnyKeywords - no results" by {
        var trackMatchList := albumFile.newAlbum.containsAnyKeywords(album1.albumTracks) search(listQuery2)
        assert (trackMatchList.asString) shouldBe ("[]")
    }
    test "containsPhrase - two results" by {
        var trackMatchList := albumFile.newAlbum.containsPhrase(album1.albumTracks) search(stringQuery1)
        assert (trackMatchList[1]) shouldBe (album1.albumTracks[4])
        assert (trackMatchList[2]) shouldBe (album1.albumTracks[7])
    }  
    test "containsPhrase - no results" by {
        var trackMatchList := albumFile.newAlbum.containsPhrase(album1.albumTracks) search(stringQuery2)
        assert (trackMatchList.asString) shouldBe ("[]")
    }  
}    
//Note: Format for obtaining second track in the second book of bookData.data[2][2]}

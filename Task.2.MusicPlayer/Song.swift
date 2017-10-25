//
//  Song.swift
//  Task.2.MusicPlayer
//
//  Created by Natalia Kapusta on 21/04/2017.
//  Copyright © 2017 Natalia Kapusta. All rights reserved.
//

import Foundation

struct Song {
    
    var title: String = ""
    var artist: String = ""
    var image: String = ""
    var song: String = ""
    
    init(title:String, artist:String, image:String, song:String){
        self.title = title
        self.artist = artist
        self.image = image
        self.song = song
    }
    
}

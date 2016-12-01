//
//  Photo.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/28/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class Photo
{
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    var image: UIImage?
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date)
    {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}


extension Photo: Equatable {}

// operators must be declared outside of the scope of a specific type 

func == (lhs: Photo, rhs: Photo) -> Bool
{
    return lhs.photoID == rhs.photoID
}

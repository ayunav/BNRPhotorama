//
//  PhotosViewController.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/27/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() { (photosResult) -> Void in
            
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos.")
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
            
        }
    }
}

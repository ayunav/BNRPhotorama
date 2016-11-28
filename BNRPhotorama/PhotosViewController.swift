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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos()
    }
}

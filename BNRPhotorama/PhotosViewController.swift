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
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    var store: PhotoStore! // ? var and !
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        
        store.fetchRecentPhotos() { (photosResult) -> Void in
            OperationQueue.main.addOperation
                {
                    switch photosResult
                    {
                    case let .Success(photos):
                        print("Successfully found \(photos.count) recent photos.")
                        self.photoDataSource.photos = photos
                    case let .Failure(error):
                        self.photoDataSource.photos.removeAll()
                        print("Error fetching recent photos: \(error)")
                    }
                    self.collectionView.reloadSections(NSIndexSet(index: 0) as IndexSet)
                }
        }
        
    }
    
}

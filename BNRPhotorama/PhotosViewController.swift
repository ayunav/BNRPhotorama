//
//  PhotosViewController.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/27/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    var store: PhotoStore! // ? var and !
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageDataForPhoto(photo: photo, completion:
            { (result) -> Void in
            
            OperationQueue.main.addOperation
                {
                    // the most recent index path
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                    // when the request finishes, only update the cell if it's still visible
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell
                {
                    cell.updateWithImage(image: photo.image)
                }
            }
        })
    }
}

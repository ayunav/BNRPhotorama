
//
//  PhotoDataSource.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/30/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource
{
    // MARK: - Properties
    
    private let CellIdentifier = "PhotosUICollectionViewCellIdentifier"
    
    var photos = [Photo]()
    
    // MARK: - Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        let photo = photos[indexPath.row]
        cell.updateWithImage(image: photo.image)
        
        return cell 
    }
}

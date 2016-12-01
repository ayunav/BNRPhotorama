//
//  PhotoDetailViewController.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 12/1/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! // why !
    {
        didSet
        {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore! // why !
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        store.fetchImageDataForPhoto(photo: photo, completion: { (result) -> Void in
            switch result
            {
            case let .Success(image):
                OperationQueue.main.addOperation
                {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("Error fetching image for photo: \(error)")
            }
        })
    }
}

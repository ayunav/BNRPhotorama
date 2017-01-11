//
//  PhotoStore.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/28/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import UIKit

enum ImageResult
{
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error
{
    case ImageCreationError
}


// constructs an URLSession and an URLRequest to fetch data from the API
class PhotoStore
{
    
    // 1. create URLSession
    
    let session: URLSession =
    {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
 
    
    // 2. construct URL to send the URLRequest, set a dataTask with request, fetch json data from the API
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void)
    {
        guard let url = FlickrAPI.recentPhotosURL() else { return }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {(data, response, error) -> Void in
            
            // validate JSON data returned from the API request
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
        }
        
        task.resume()
    }

    
    // 3. validate/process JSON data that is returned by the web service request
    
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult
    {
        guard let jsonData = data else
        {
            return .Failure(error!)
        }
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }
    
    
    // 4. fetch image data for a Photo object
    
    func fetchImageDataForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void)
    {
        if let image = photo.image
        {
            completion(.Success(image))
            return
        }
        
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        
        let task = session.dataTask(with: request) {(data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result // could be  if result = case let .Success(image) ? 
                
            {
                photo.image = image
            }
            
            completion(result)
        }
        
        task.resume()
    }
    
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult
    {
        guard let imageData = data, let image = UIImage(data: imageData) else
        {
            if data == nil
            {
                return .Failure(error!)
            } else
            {
                return .Failure(PhotoError.ImageCreationError)
            }
        }
        return .Success(image)
    }
}

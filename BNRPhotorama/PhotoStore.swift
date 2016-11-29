//
//  PhotoStore.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/28/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation


// constructs an URLSession and an URLRequest to fetch data from the API 
class PhotoStore
{
    
    // 1. create URLSession
    
    let session: URLSession =
    {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
 
    
    // 2. construct URL to send the URLRequest, set a dataTask with request, fetch json data from the API,
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void)
    {
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url!)
        
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
    
    
}

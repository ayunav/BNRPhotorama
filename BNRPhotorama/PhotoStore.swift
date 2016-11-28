//
//  PhotoStore.swift
//  BNRPhotorama
//
//  Created by Ayuna NYC on 11/28/16.
//  Copyright © 2016 Ayuna NYC. All rights reserved.
//

import Foundation

class PhotoStore
{
    let session: URLSession =
    {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
 
    func fetchRecentPhotos()
    {
        let url = FlickrAPI.recentPhotosURL()
        let request = URLRequest(url: url!)
        
        let task = session.dataTask(with: request)
            { (data, response, error) -> Void in
            
                if let jsonData = data
                {
                    if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
                    {
                        print(jsonString)
                    }
                }
                else if let requestError = error
                {
                    print("Error fetching recent photos: \(requestError)")
                }
                else
                {
                    print("Unxpected error with the request")
                }
            }
        task.resume()
    }

}

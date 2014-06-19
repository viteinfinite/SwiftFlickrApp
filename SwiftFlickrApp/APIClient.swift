//
//  APIClient.swift
//  SwiftFlickrApp
//
//  Created by Simone Civetta on 19/06/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import Foundation

class APIClient {
    
    let manager :AFHTTPRequestOperationManager = AFHTTPRequestOperationManager()
    
    func getFlickrPhotos(success:(photos:Dictionary<String, String>[]) -> (), failure:(error:NSErrorPointer) -> ())
    {
        let url :String = "https://api.flickr.com/services/rest/"
        let parameters :Dictionary = [
            "method"         : "flickr.interestingness.getList",
            "api_key"        : "86997f23273f5a518b027e2c8c019b0f",
            "per_page"       : "99",
            "format"         : "json",
            "nojsoncallback" : "1",
            "extras"         : "url_q,url_z",
        ]
        let requestSuccess = {
            (operation :AFHTTPRequestOperation!, responseObject :AnyObject!) -> Void in
            var photos = responseObject.objectForKey("photos").objectForKey("photo") as Dictionary<String, String>[]
            success(photos: photos)
        }
        let requestFailure = {
            (operation :AFHTTPRequestOperation!, error :NSError!) -> Void in
            var innerError: NSError? = error
            failure(error: &innerError)
        }
        SVProgressHUD.show()
        self.manager.GET(url, parameters: parameters, success: requestSuccess, failure: requestFailure)
    }
}


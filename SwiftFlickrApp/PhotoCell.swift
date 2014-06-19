//
//  PhotoCell.swift
//  SwiftFlickrApp
//
//  Created by synboo on 6/5/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell
{
    @IBOutlet var photoImageView : UIImageView
    var photoInfo : Dictionary<String, String>? {
        didSet {
            self.loadPhoto()
        }
    }
    
    func loadPhoto()
    {
        let photoUrlString = self.frame.width >= 320 ? photoInfo?["url_z"] : photoInfo?["url_q"]
        let photoUrlRequest : NSURLRequest = NSURLRequest(URL: NSURL.URLWithString(photoUrlString))
        
        let imageRequestSuccess = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, image : UIImage!) -> Void in
            self.photoImageView.image = image;
            self.photoImageView.alpha = 0
            UIView.animateWithDuration(0.2, animations: {
                self.photoImageView.alpha = 1.0
            })
        }
        let imageRequestFailure = {
            (request : NSURLRequest!, response : NSHTTPURLResponse!, error : NSError!) -> Void in
            NSLog("imageRequrestFailure")
        }
        self.photoImageView.setImageWithURLRequest(photoUrlRequest, placeholderImage: nil, success: imageRequestSuccess, failure: imageRequestFailure)
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    
    
}

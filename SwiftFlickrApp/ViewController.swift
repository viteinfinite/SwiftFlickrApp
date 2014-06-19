//
//  ViewController.swift
//  SwiftFlickrApp
//
//  Created by synboo on 6/5/14.
//  Copyright (c) 2014 synboo. All rights reserved.
//

import UIKit

enum LayoutType: Int
{
    case Grid = 0
    case List = 1
}

class ViewController: UICollectionViewController
{
    var photos:Dictionary<String, String>[] = []
    var layoutType = LayoutType.Grid
    var apiClient:APIClient
    
    init(coder aDecoder: NSCoder!)
    {
        self.apiClient = APIClient()
        super.init(coder: aDecoder)        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.apiClient.getFlickrPhotos({
            photos in
            self.photos = photos
            SVProgressHUD.dismiss()
            self.collectionView.reloadData()
        }, {
            error in
            SVProgressHUD.dismiss()
            NSLog("requestFailure: \(error)")
        })
    }
    
    // MARK: - Collection View
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.photos.count;
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        let photoCell: PhotoCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("PhotoCell", forIndexPath: indexPath) as PhotoCell
        let photoInfo = photos[indexPath.item] as Dictionary

        photoCell.photoInfo = photoInfo
        return photoCell;
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        var itemSize : CGSize
        if self.layoutType == LayoutType.Grid
        {
            itemSize = (indexPath.item%3 == 1) ? CGSizeMake(106, 106) : CGSizeMake(107, 106)
        }
        else
        {
            itemSize = CGSizeMake(320, 150)
        }
        return itemSize
    }
    
    // MARK: - IBAction
    
    @IBAction func segmentedControlDidChange(control : UISegmentedControl)
    {
        switch control.selectedSegmentIndex {
        case 0:
            self.layoutType = LayoutType.Grid
        case 1:
            self.layoutType = LayoutType.List
        default:
            self.layoutType = LayoutType.Grid
        }
        
        self.collectionView.reloadData()
    }
    
    // MARK: - Segue

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
    {
        if segue.identifier == "ShowPhoto"
        {
            let photoCell : PhotoCell = sender as PhotoCell
            var photoViewController = segue.destinationViewController as PhotoViewController
            photoViewController.photoInfo = photoCell.photoInfo
        }
    }
}


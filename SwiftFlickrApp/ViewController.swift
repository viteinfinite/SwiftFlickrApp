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
        
        SVProgressHUD.show()
        
        // -> 2 <-
        // @TODO
        // Use apiClient to retrieve the photos
        // if the loading succeeds: 
        //   1. set the self.photos dictionary to the received response
        //   2. dismiss the progress HUD
        //   3. reload the collection view
        // if the loading fails:
        //   1. dismiss the progress HUD
        
        
        
        // Your code goes here

    }
    
    // MARK: - Collection View
    
    override func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.photos.count;
    }
    
    override func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell!
    {
        var photoCell:PhotoCell
        
        // -> 1 <-
        // @TODO
        // 0. Remove "return nil" on the bottom of this function
        // 1. Dequeue the cell using dequeueReusableCellWithReuseIdentifier
        // 2. Retrieve the item at the required index (indexPath.item) from the photo dictionary
        // 3. Set the photoInfo property on photoCell
        // 4. Return photoCell
        
        
        // Your code goes here
        
        
        // Remove me
        return nil
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize
    {
        var itemSize : CGSize
        if self.layoutType == LayoutType.Grid {
            itemSize = (indexPath.item%3 == 1) ? CGSizeMake(106, 106) : CGSizeMake(107, 106)
        } else {
            itemSize = CGSizeMake(320, 150)
        }
        return itemSize
    }
    
    
    // MARK: - IBAction
    
    @IBAction func segmentedControlDidChange(control : UISegmentedControl)
    {
        // -> 3 <-
        // @TODO
        // Implement the switch statement and set "self.layoutType" according to the choice:
        // 0 and default should set self.layoutType to Grid
        // 1 should set self.layoutType to List
        
        
        
        // Your code goes here
        
        
        
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


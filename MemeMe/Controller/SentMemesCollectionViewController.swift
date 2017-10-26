//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
    }

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)  as! MemeCollectionViewCell
        
         let meme = self.memes[(indexPath as NSIndexPath).row]
    
        // Configure the cell
        
        cell.memeImageView.image = meme.originalMeme
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.bottomText
    
        return cell
        
    }


    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
//        // Grab the DetailVC from Storyboard
//        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
//        
//        //Populate view controller with data from the selected item
//        detailController.villain = allVillains[(indexPath as NSIndexPath).row]
//        
//        // Present the view controller using navigation
//        navigationController!.pushViewController(detailController, animated: true)
        
    }
 
    

}

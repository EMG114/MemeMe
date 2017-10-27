//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let space:CGFloat = 3.0
        let widthDimension = (view.frame.size.width - (2 * space)) / 3.0
        let heightDimension = (view.frame.size.height - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    
    
    @IBAction func removeAllMemeButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Delete All", message: "This will DELETE ALL Memes", preferredStyle: .actionSheet)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.removeAll()
        memes.removeAll()
        collectionView?.reloadData()
        
    }
    
    @IBAction func addNewMemeButton(_ sender: Any) {
        
        let newMemeViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        present(newMemeViewController, animated: true, completion: nil)
        
        
    }
    
  

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath)  as! MemeCollectionViewCell
        
         let meme = self.memes[(indexPath as NSIndexPath).row]
    
        // Configure the cell
        
        cell.memeImageView.image = meme.memedImage
      
        return cell
        
    }


    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MasterDetail") as! MasterDetailViewController
        
        detailController.image = memes[indexPath.row].memedImage
        
        navigationController!.pushViewController(detailController, animated: true)

        
    }
 
    

}

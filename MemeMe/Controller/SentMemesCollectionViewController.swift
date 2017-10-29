//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit


class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var removeAllButton: UIBarButtonItem!
    
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
        
        removeAllButton.isEnabled = false
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
        
        if appDelegate.memes.count > 0 {
            removeAllButton.isEnabled = true
        }
    }
    
    
    
    @IBAction func removeAllMemeButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Remove All?", message: "Do you want to DELETE ALL memes?", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAll()
            self.memes.removeAll()
            self.collectionView?.reloadData()
            
            
        }
        alertController.addAction(OKAction)
        
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
        
    }
    
    @IBAction func addNewMemeButton(_ sender: Any) {
        
        let newMemeViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        present(newMemeViewController, animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
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

//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var removeAllButton: UIBarButtonItem!
    var memes: [Meme]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeAllButton.isEnabled = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
        
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
            self.tableView.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.memes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell") as! MemeTableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
      
//        tableCell.imageView?.image = meme.memedImage
//        tableCell.topTextLabel.text = meme.topText
//        tableCell.bottomTextLabel.text = meme.bottomText
        
         tableCell.setupCellWith(meme: meme)
        
         return tableCell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            memes.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: "MasterDetail") as! MasterDetailViewController
        
        detailController.image = memes[indexPath.row].memedImage
        
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100.0
    }
    
}

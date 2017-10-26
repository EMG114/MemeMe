//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
     var memes: [Meme]!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
         return memes.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "memeTableCell") as! UITableViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
       // tableCell.imageView = meme.originalMeme
        //tableCell.textLabel =
        
        return tableCell
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

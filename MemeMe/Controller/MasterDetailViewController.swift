//
//  MasterDetailViewController.swift
//  MemeMe
//
//  Created by Erica on 10/26/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class MasterDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Override Functions
    override func viewWillAppear(_ animated: Bool) {
        detailImage.image = image
        
    }
    
}

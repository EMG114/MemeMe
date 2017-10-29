//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Erica on 10/25/17.
//  Copyright © 2017 Erica Gutierrez. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var memedImageView: UIImageView!
    
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var topTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCellWith(meme:Meme) {
        
        memedImageView.image = meme.memedImage
        bottomTextLabel.text = meme.bottomText
        topTextLabel.text = meme.topText
        
}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

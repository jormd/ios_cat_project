//
//  CatTableViewCell.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import UIKit
import Kingfisher

class CatTableViewCell: UITableViewCell {

    @IBOutlet weak var textLabelCat: UILabel!
    @IBOutlet weak var imageCat: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(withCat cat: Cat){
        textLabelCat.text = cat.text
                
        
        let catUrl = URL(string: cat.image ?? "")
        imageCat.kf.setImage(with: catUrl)
        
        
    }

}

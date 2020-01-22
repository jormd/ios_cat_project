//
//  CatFavTableViewCell.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import UIKit
import Kingfisher

class CatFavTableViewCell: UITableViewCell {
    @IBOutlet weak var imageFavCat: UIImageView!
    @IBOutlet weak var labelCatFav: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(withCat cat: Cat){
        labelCatFav.text = cat.text
        
        let catUrl = URL(string: cat.image ?? "")
        imageFavCat.kf.setImage(with: catUrl)
    }

}

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
    
    var idCat : String = ""

    @IBOutlet weak var textLabelCat: UILabel!
    @IBOutlet weak var imageCat: UIImageView!
    @IBAction func btnFavori(_ sender: Any) {
        var ids = [String]()
        
        if(UserDefaults.standard.array(forKey: "fav") != nil){
            ids = UserDefaults.standard.array(forKey: "fav") as! [String]
        }
                
        if(find(value: idCat, in: ids ) == nil){
            ids.append(idCat)
        }
        
        UserDefaults.standard.set(ids, forKey: "fav")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fill(withCat cat: Cat){
        idCat = cat._id
        
        textLabelCat.text = cat.text
                
        let catUrl = URL(string: cat.image ?? "")
        imageCat.kf.setImage(with: catUrl)
    }
    
    func find(value searchValue: String, in array: [String]) -> Int?
    {
        for (index, value) in array.enumerated()
        {
            if value == searchValue {
                return index
            }
        }

        return nil
    }

}

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
        
        self.BtnFav.setBackgroundImage(UIImage(named: "star_fav"), for: .normal)

        
        UserDefaults.standard.set(ids, forKey: "fav")
    }
    @IBOutlet weak var BtnFav: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.BtnFav.setBackgroundImage(UIImage(named: "star_empty"), for: .normal)
    }

    func fill(withCat cat: Cat){
        idCat = cat._id
        
        if(UserDefaults.standard.array(forKey: "fav") != nil){
            var ids = UserDefaults.standard.array(forKey: "fav") as! [String]
            
            if(find(value: idCat, in: ids  ) != nil){
                self.BtnFav.setBackgroundImage(UIImage(named: "star_fav"), for: .normal)
            }
            else{
                self.BtnFav.setBackgroundImage(UIImage(named: "star_empty"), for: .normal)
            }
            
        }
        
        textLabelCat.text = cat.text
                
        let catUrl = URL(string: cat.image ?? "")
        imageCat.kf.setImage(with: catUrl, placeholder: UIImage(named: "telechargement"), options: [.transition(.fade(1))])
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

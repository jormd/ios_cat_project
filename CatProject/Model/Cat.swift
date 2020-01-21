//
//  Cat.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import Foundation
import UIKit

class Cat: Codable {
    
    var text: String
    var _id: String
    var image: String?
    
    init(text: String, _id: String, image: String?){
        self.text = text
        self._id = _id
        self.image = image
    }

}

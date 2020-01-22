//
//  FavorisViewController.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import UIKit
import Alamofire

class FavorisViewController: UIViewController {

    var listCatFactFav: [Cat] = []
    @IBOutlet weak var tableCatFav: UITableView!
    
    //@IBOutlet weak var catTableViewFav: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
        tableCatFav.delegate = self
        tableCatFav.dataSource = self
        tableCatFav.rowHeight = UITableView.automaticDimension
        tableCatFav.estimatedRowHeight = 100
    }
    
    func setup(){
        getCatFacts()
    }

    private func getCatFacts(){
        var ids = UserDefaults.standard.array(forKey: "fav") ?? []
        
        for id in ids{
            let apiFactsUrl = "https://cat-fact.herokuapp.com/facts/\(id)"
            AF.request(apiFactsUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<Cat, AFError>) in
                switch response.result {
                case .success(let catFact):
                    print(catFact.text)
                    self?.listCatFactFav.append(Cat(text: catFact.text, _id: catFact._id, image: ""))
                    
                    self?.getCatPicture()
                    self?.tableCatFav.reloadData()

                case .failure(let error):
                    print(error.errorDescription ?? "")

                }
            }
        }
        
        
    }
    
    private func getCatPicture(){
        
        
        let apiPictureUrl = "https://api.thecatapi.com/v1/images/search?limit=100&order=random"

        AF.request(apiPictureUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<[PictureCat], AFError>) in
            switch response.result{
            case .success(let pictureCat):
                for (index, listCat) in (self?.listCatFactFav.enumerated())!{
                    
                    var indexPictureCat = Int.random(in: 1..<99)
                    listCat.image = pictureCat[indexPictureCat].url

                }
                
                self?.tableCatFav.reloadData()
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
}

extension FavorisViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            
    }
}

extension FavorisViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCatFactFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellDynamique = tableView.dequeueReusableCell(withIdentifier: "catCellFavID", for: indexPath) as? CatFavTableViewCell {
            
            let catFact = self.listCatFactFav[indexPath.row]
            cellDynamique.fill(withCat: catFact)
            
            return cellDynamique
        }else {
            return UITableViewCell()
        }
    }
    
    
}

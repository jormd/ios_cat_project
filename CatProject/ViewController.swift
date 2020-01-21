//
//  ViewController.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var listCatFact: [Cat] = []
        /*[
        Cat(factCat: "claude", idCat: "1", image: ""),
        Cat(factCat: "bernard", idCat: "2", image: ""),
    ]*/

    @IBOutlet weak var catTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Cat fact"
        setup()
        catTableView.delegate = self
        catTableView.dataSource = self
        catTableView.rowHeight = UITableView.automaticDimension
        catTableView.estimatedRowHeight = 100
    }
    
    func setup(){
        getCatFacts()
        getCatPicture()
    }

    
    private func getCatFacts(){
        let apiFactsUrl = "https://cat-fact.herokuapp.com/facts"        
        AF.request(apiFactsUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<AllCat, AFError>) in
            switch response.result {
            case .success(let catFacts):
                for catFact in catFacts.all ?? [] {
                    
                    self?.listCatFact.append(Cat(text: catFact.text, _id: catFact._id, image: ""))
                    
                }
                self?.catTableView.reloadData()
            case .failure(let error):
                print(error.errorDescription ?? "")
                
            }
        }
    }
    
    private func getCatPicture(){
        
        
        let apiPictureUrl = "https://api.thecatapi.com/v1/images/search?limit=100&order=random"

        AF.request(apiPictureUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<[PictureCat], AFError>) in
            switch response.result{
            case .success(let pictureCat):
                for (index, listCat) in (self?.listCatFact.enumerated())!{
                    
                    var indexPictureCat = Int.random(in: 0..<100)
                    
                    listCat.image = pictureCat[indexPictureCat].url

                }
                
                self?.catTableView.reloadData()

            case .failure(let error):
                print("no")
                print(error.errorDescription ?? "")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selectCatFact = listCatFact[indexPath.row]        
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCatFact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellDynamique = tableView.dequeueReusableCell(withIdentifier: "catCellID", for: indexPath) as? CatTableViewCell {
            
            let catFact = self.listCatFact[indexPath.row]
            cellDynamique.fill(withCat: catFact)
            
            return cellDynamique
        }else {
            return UITableViewCell()
        }
        
    }
    
}

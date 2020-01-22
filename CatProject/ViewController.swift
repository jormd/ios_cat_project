//
//  ViewController.swift
//  CatProject
//
//  Created by johann on 21/01/2020.
//  Copyright © 2020 johann. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class ViewController: UIViewController {
    
    var listCatFact: [Cat] = []
    var catSound: AVAudioPlayer?
    let listOfCatSound = ["cat1.mp3", "cat2.mp3", "cat3.mp3", "cat4.mp3", "cat5.mp3"]

    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
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
    }
    
    func playCatSound() {
         let catSoundField = listOfCatSound.randomElement()
         
         let path = Bundle.main.path(forResource: catSoundField, ofType:nil)!
         let url = URL(fileURLWithPath: path)
         do {
             catSound = try AVAudioPlayer(contentsOf: url)
             catSound?.stop()
             catSound?.play()
         } catch {
             // couldn't load file
         }
     }

    
    private func getCatFacts(){
        self.loader.startAnimating()
        let apiFactsUrl = "https://cat-fact.herokuapp.com/facts"        
        AF.request(apiFactsUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<AllCat, AFError>) in
            switch response.result {
            case .success(let catFacts):
                for catFact in catFacts.all ?? [] {
                    self?.listCatFact.append(Cat(text: catFact.text, _id: catFact._id, image: ""))
                }
                self?.getCatPicture()

            case .failure(let error):
                print(error.errorDescription ?? "")
                self?.loader.stopAnimating()

            }
        }
    }
    
    private func getCatPicture(){
        
        
        let apiPictureUrl = "https://api.thecatapi.com/v1/images/search?limit=100&order=random"

        AF.request(apiPictureUrl, method: .get).responseDecodable { [weak self] (response: DataResponse<[PictureCat], AFError>) in
            switch response.result{
            case .success(let pictureCat):
                for listCat in self?.listCatFact ?? []{
                    
                    let indexPictureCat = Int.random(in: 0..<99)
                    
                    listCat.image = pictureCat[indexPictureCat].url

                }
                self?.loader.stopAnimating()
                self?.catTableView.reloadData()
            case .failure(let error):
                print(error.errorDescription ?? "")
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playCatSound()
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

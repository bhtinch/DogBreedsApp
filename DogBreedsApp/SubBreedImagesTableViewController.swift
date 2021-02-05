//
//  SubBreedImagesTableViewController.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import UIKit

class SubBreedImagesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let subBreed = subBreed,
              let breed = breed else { return }
        
        SubBreedController.fetchSubBreedImageURLs(ofBreed: breed, ofSubBreed: subBreed) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let imageURLs):
                    self.imageURLs = imageURLs
                    print(imageURLs.count)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        navigationItem.title = "\(subBreed.uppercased()) \(breed.uppercased())"

    }
    
    //  MARK: Properties
    var breed: String?
    var subBreed: String?
    
    var imageURLs: [URL]?

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let imageURLs = imageURLs else { return 0 }
        //print(images.count)
        return imageURLs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subBreedImageCell", for: indexPath) as? SubBreedImageTableViewCell,
              let imageURLs = imageURLs else { return UITableViewCell() }
        
        cell.subBreedImageURL = imageURLs[indexPath.row]

        return cell
    }

}

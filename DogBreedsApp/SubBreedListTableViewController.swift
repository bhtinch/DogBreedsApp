//
//  SubBreedListTableViewController.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import UIKit

class SubBreedListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let breed = breed else { return }
        
        SubBreedController.fetchSubBreedList(ofBreed: breed) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let subBreeds):
                    if subBreeds == [] {
                        self.subBreeds = [breed]
                    } else {
                        self.subBreeds = subBreeds
                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        navigationItem.title = "Sub-Breeds of: \(breed.uppercased())"

    }
    
    //  MARK: Properties
    var breed: String?
    var subBreeds: [String] = []

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subBreeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subBreedCell", for: indexPath)

        let subBreed = subBreeds[indexPath.row]
        cell.textLabel?.text = subBreed.capitalized
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubBreedImagesVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SubBreedImagesTableViewController,
                  let breed = breed else { return }
            let subBreed = subBreeds[indexPath.row]
            destination.breed = breed
            destination.subBreed = subBreed
        }
    }

}

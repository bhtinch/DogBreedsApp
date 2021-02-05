//
//  BreedListTableViewController.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import UIKit

class BreedListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SubBreedController.fetchBreedList { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let breeds):
                    self.breeds = breeds
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }

    }
    
    //  MARK: Properties
    var breeds: [String] = []

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)

        let breed = breeds[indexPath.row]
        cell.textLabel?.text = breed.capitalized

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubBreedVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SubBreedListTableViewController else { return }
            destination.breed = breeds[indexPath.row]
        }
    }

}

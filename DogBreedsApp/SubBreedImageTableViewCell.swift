//
//  SubBreedImageTableViewCell.swift
//  DogBreedsApp
//
//  Created by Benjamin Tincher on 1/28/21.
//

import UIKit

class SubBreedImageTableViewCell: UITableViewCell {

    @IBOutlet weak var subBreedImageView: UIImageView!
    
    var subBreedImageURL: URL? {
        didSet {
            guard let url = subBreedImageURL else { return }
            fetchImage(url: url)
        }
    }
    
    func fetchImage(url: URL) {
        
        SubBreedController.fetchSubBreedImage(withURL: url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.updateView(image: image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateView(image: UIImage) {
        subBreedImageView.image = image
    }
    
    
}

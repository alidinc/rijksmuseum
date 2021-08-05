//
//  ArtworkCollectionViewCell.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 04/08/2021.
//

import UIKit

class ArtworkCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Properties
    var artObject: ArtObject? {
        didSet {
            updateViews()
        }
    }

    // MARK: - Helpers
    func updateViews() {
        guard let artObject = artObject else { return }
        let imageURL = artObject.webImage.url
        
        ArtworkController.fetchImageForArtObjects(imageURL: imageURL) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.imageView.image = image
                case .failure(_):
                    self.imageView.image = UIImage(named: Constants.defaultCellImageID)
                }
            }
        }
    }
}

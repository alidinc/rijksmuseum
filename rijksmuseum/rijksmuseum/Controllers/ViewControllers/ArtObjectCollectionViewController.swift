//
//  ArtworkCollectionViewController.swift
//  rijksmuseum
//
//  Created by Ali Dinç on 04/08/2021.
//

import UIKit


class ArtObjectCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    var artObjects = [ArtObject]()
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArtWorksToLoad()
    }
    
    // MARK: - Helpers
    
    func fetchArtWorksToLoad() {
        ArtworkController.fetchArtObjects { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artObjects):
                    self.artObjects = artObjects
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension ArtObjectCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artObjects.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellID, for: indexPath) as? ArtworkCollectionViewCell else { return UICollectionViewCell() }
        let artwork = self.artObjects[indexPath.row]
        cell.artObject = artwork
        return cell
    }
}

// MARK: -  Navigation
extension ArtObjectCollectionViewController {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.detailVCID {
            guard let cell = sender as? UICollectionViewCell else { return }
            guard let indexPath = collectionView.indexPath(for: cell),
                  let destination = segue.destination as? ArtObjectDetailViewController else { return }
            
            let artObject = self.artObjects[indexPath.item]
            destination.artObject = artObject
        }
    }
    
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let detailVC = storyboard.instantiateViewController(withIdentifier: Constants.detailVCStoryboardID) as? ArtObjectDetailViewController else { return }
//
//        let artObject = self.artObjects[indexPath.item]
//        detailVC.artObject = artObject
//        detailVC.modalPresentationStyle = .fullScreen
//        navigationController?.present(detailVC, animated: false, completion: nil)
//    }
}


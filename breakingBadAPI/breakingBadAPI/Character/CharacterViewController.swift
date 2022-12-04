//
//  ViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 25.11.2022.
//

import UIKit

class CharacterViewController: BaseViewController {
    //MARK: Variables
    @IBOutlet private weak var characterCollectionView: UICollectionView!
    private var character: [CharactersModel]? {
        didSet {
            characterCollectionView.reloadData()
        }
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        indicator.startAnimating()
        fetchCharacters()
    }
    //MARK: Methods
    func fetchCharacters() {
        Client.shared.getCharacters { [weak self] result in
            switch result {
            case .success(let results):
                self?.character = results
                self?.indicator.stopAnimating()
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func configureCollectionView() {
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        characterCollectionView.register(UINib(nibName: "CharacterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
    }
}

//MARK: Extensions
extension CharacterViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        character?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCollectionViewCell
        cell.configure(model: character?[indexPath.row])
        return cell
    }
}

extension CharacterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: CharacterDetailViewController.self)) as? CharacterDetailViewController else { return }
        let selectedCharacter = character?[indexPath.row]
        detailVC.characterID = selectedCharacter?.charID
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


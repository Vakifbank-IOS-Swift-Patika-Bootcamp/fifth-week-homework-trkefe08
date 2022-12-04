//
//  CharacterDetailViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 26.11.2022.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: BaseViewController {
    //MARK: Variables
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet private weak var portrayedLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet weak var quotesButton: UIButton! {
        didSet {
            quotesButton.titleLabel?.text = "Quotes"
        }
    }
    
    var characterID : Int?
    private var singleCharacter: [CharactersModel]?
    private var single: CharactersModel?
    private var quotes: QuotesModel?
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        fetchDetails()
        configureComponents()
    }
    
    //MARK: Methods
    func fetchDetails() {
        Client.shared.getSingleCharacter(with: characterID ?? 0) { [weak self] result in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self?.singleCharacter = details
                    self?.indicator.stopAnimating()
                    self?.configureComponents()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func configureComponents() {
        if let url = URL(string: "\(singleCharacter?[0].img ?? "not found")" ) {
            characterImageView.kf.setImage(with: url)
        }
        nameLabel.text = "Name: \(singleCharacter?[0].name ?? "-")"
        birthdayLabel.text = "Birthday: \(singleCharacter?[0].birthday ?? "-")"
        portrayedLabel.text = "Portrayed: \(singleCharacter?[0].portrayed ?? "-")"
        categoryLabel.text = "Category: \(singleCharacter?[0].category ?? "-")"
    }
    
    @IBAction func quotesButton(_ sender: Any) {
        guard let quotesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: QuotesViewController.self)) as? QuotesViewController else { return }
        let result = nameLabel.text?.split(separator: " ")
        let name = result?[1]
        let surname = result?[2]
        quotesVC.quotesAuthorName = String(name ?? "")
        quotesVC.quotesAuthorSurname = String(surname ?? "")
        self.navigationController?.pushViewController(quotesVC, animated: true)
    }
}

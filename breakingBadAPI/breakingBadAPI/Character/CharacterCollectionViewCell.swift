//
//  CharacterCollectionViewCell.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 26.11.2022.
//

import UIKit
import Kingfisher

class CharacterCollectionViewCell: UICollectionViewCell {
    //MARK: Variables
    @IBOutlet weak var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
            characterImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: Methods
    func configure(model: CharactersModel?) {
        if let url = URL(string: "\(model?.img ?? "not found")" ) {
            characterImageView.kf.setImage(with: url)
        }
        nameLabel.text = "Name:\(model?.name ?? "-")"
        birthdayLabel.text = "Birthday:\(model?.birthday ?? "-")"
        nicknameLabel.text = "Nickname:\(model?.nickname ?? "-")"
    }
}

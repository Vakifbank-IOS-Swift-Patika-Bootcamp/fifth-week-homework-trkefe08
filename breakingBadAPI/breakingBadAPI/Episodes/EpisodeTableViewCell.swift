//
//  EpisodeTableViewCell.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    //MARK: Variables
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    //MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK: Methods
    func configureEpisodeCell(model: EpisodeModel?) {
        titleLabel.text = "Episode Name: \(model?.title ?? "")"
        seasonLabel.text = "Season \(model?.season ?? "")"
        episodeLabel.text = "Episode \(model?.episode ?? "")"
    }
}

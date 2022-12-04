//
//  NoteTableViewCell.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 3.12.2022.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(model: Note) {
        seasonLabel.text = model.seasonText
        episodeLabel.text = model.episodeText
        noteLabel.text = model.noteText
    }
}

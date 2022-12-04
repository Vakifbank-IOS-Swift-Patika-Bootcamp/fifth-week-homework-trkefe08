//
//  AddEditViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 30.11.2022.
//

import UIKit

class AddEditViewController: BaseViewController {

    @IBOutlet weak var seasonText: UITextField!
    @IBOutlet weak var episodeText: UITextField!
    @IBOutlet weak var noteText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let season = seasonText.text, season.isEmpty {
            showErrorAlert(message: "Season kısmı boş kalamaz") {
            }
        } else if let part = episodeText.text, part.isEmpty {
            showErrorAlert(message: "Episode kısmı boş kalamaz") {
            }
        } else if let not = noteText.text, not.isEmpty {
            showErrorAlert(message: "Not kısmı boş kalamaz") {
            }
        }
        CoreDataManager.shared.saveNote(nText: noteText.text ?? "", sText: seasonText.text ?? "", eText: episodeText.text ?? "")
        guard let noteListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: NoteListViewController.self)) as? NoteListViewController else { return }
            self.navigationController?.pushViewController(noteListVC, animated: true)
    }
}

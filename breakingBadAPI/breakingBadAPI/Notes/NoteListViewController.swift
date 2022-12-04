//
//  NoteListViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 30.11.2022.
//

import UIKit

class NoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var noteTableView: UITableView!
    
    var notes: [Note] = []
    
    private let floatingButton: UIButton = {
        let button = UIButton (frame: CGRect(x: 0, y: 0, width: 60, height: 60) )
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemPink
        
        let image = UIImage (systemName: "plus",
                             withConfiguration: UIImage.SymbolConfiguration (pointSize: 32, weight: .medium))
        button.setImage (image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.addSubview (floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        notes = CoreDataManager.shared.getNotes()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x: view.frame.size.width - 65,
            y: view.frame.size.height - 150,
            width: 60,
            height: 60)
    }

    @objc private func didTapButton() {
        guard let addEditVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AddEditViewController.self)) as? AddEditViewController else { return }
        self.navigationController?.pushViewController(addEditVC, animated: true)
    }
    
    private func configureTableView() {
        noteTableView.delegate = self
        noteTableView.dataSource = self
        noteTableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        noteTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(model: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteNote = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] _, indexPath in
            guard let self = self else { return }
            CoreDataManager.shared.deleteNote(note: self.notes[indexPath.row])
            self.notes.remove(at: indexPath.row)
            tableView.reloadData()
        }
        deleteNote.backgroundColor = .red
        return [deleteNote]
    }
}

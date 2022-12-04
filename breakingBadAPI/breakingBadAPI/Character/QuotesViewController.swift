//
//  QuotesViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import UIKit

class QuotesViewController: UIViewController {
    //MARK: Variables
    @IBOutlet weak var quotesTableView: UITableView!
    var quotesAuthorName: String = ""
    var quotesAuthorSurname: String = ""
    private var quotes: [QuotesModel]? {
        didSet {
            quotesTableView.reloadData()
        }
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotesTableView.dataSource = self
        Client.shared.getQuotes(with: quotesAuthorName, with: quotesAuthorSurname) { [weak self] result in
            switch result {
            case .success(let results):
                self?.quotes = results
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
//MARK: Extension
extension QuotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = quotesTableView.dequeueReusableCell(withIdentifier: "QuotesCell", for: indexPath) as! QuotesTableViewCell
        cell.configure(model: quotes?[indexPath.row])
        
        return cell
    }
}

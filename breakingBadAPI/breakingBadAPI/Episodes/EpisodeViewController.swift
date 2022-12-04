//
//  EpisodeViewController.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import UIKit

class EpisodeViewController: BaseViewController {
    //MARK: Variables
    @IBOutlet weak var episodeTableView: UITableView! {
        didSet {
            episodeTableView.delegate = self
            episodeTableView.dataSource = self
            episodeTableView.register(UINib(nibName: "EpisodeTableViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        }
    }
    private var epi : EpisodeModel?
    private var episode: [EpisodeModel]? {
        didSet {
            episodeTableView.reloadData()
        }
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        Client.shared.getEpisodes { [weak self] result in
            switch result {
            case .success(let results):
                self?.episode = results
                self?.indicator.stopAnimating()
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

//MARK: Extensions
extension EpisodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episode?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = episodeTableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as! EpisodeTableViewCell
        cell.configureEpisodeCell(model: episode?[indexPath.row])
        return cell
    }
}

extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.epi = episode![indexPath.row]
        let newView = XibView(frame: CGRect(origin: CGPointMake(view.center.x - 100, view.center.y - 100), size: CGSize(width: 200, height: 200)))
        newView.alpha = 0
        UIView.animate(withDuration: 2.0) {
            newView.alpha = 1
        }
        newView.delegate = self
        newView.configure(model: epi)
        view.addSubview(newView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension EpisodeViewController: XibViewDelegate {
    func close() {
        showErrorAlert(message: "Closed") {
            return
        }
    }
}


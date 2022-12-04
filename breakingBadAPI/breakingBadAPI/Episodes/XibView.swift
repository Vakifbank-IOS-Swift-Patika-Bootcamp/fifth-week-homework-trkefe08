//
//  XibView.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import UIKit

protocol XibViewDelegate: AnyObject {
    func close()
}

class XibView: UIView {
    weak var delegate: XibViewDelegate?
    //MARK: Variables
    @IBOutlet weak var charactersLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    //MARK: Methods
    private func customInit() {
        let nib = UINib(nibName: "XibView", bundle: nil)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            addSubview(view)
            view.frame = self.bounds
        }
    }

    @IBAction func closeButton(_ sender: Any) {
        delegate?.close()
        removeFromSuperview()
    }
    
    func configure(model: EpisodeModel?) {
        let characterString = model?.characters
        charactersLabel.text = characterString?.joined(separator: ",")
    }
}

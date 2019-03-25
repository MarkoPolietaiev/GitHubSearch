//
//  RepoItemTableViewCell.swift
//  GitHubSearch
//
//  Created by Marko Polietaiev on 3/24/19.
//  Copyright © 2019 Marko Polietaiev. All rights reserved.
//

import UIKit

class RepoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var popularityView: UIView!
    
    var model: Repo!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        popularityView.layer.borderWidth = 1
        popularityView.layer.borderColor = (UIColor.black).cgColor
        popularityView.layer.cornerRadius = 2
        // Initialization code
    }
    
    func setupWithModel(_ model: Repo, id: Int) {
        self.model = model
        titleLabel.text = model.name
        descriptionLabel.text = model.repoDescription
        idLabel.text = String(id)
        popularityLabel.text = String(model.popularity)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

//
//  PostTableViewCell.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with post: Post) {
        titleLabel.text = "#\(post.id). " + post.title
        bodyLabel.text = post.body
    }
}

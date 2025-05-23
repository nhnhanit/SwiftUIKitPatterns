//
//  PostTableViewCell.swift
//  SwiftUIKitPatterns
//
//  Created by hongnhan on 22/5/25.
//

import UIKit

protocol PostTableViewCellDelegate: AnyObject {
    func postCellDidTapDelete(_ cell: PostTableViewCell)
    func postCellDidTapFavorite(_ cell: PostTableViewCell, post: Post)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let deleteImage = UIImage(systemName: "trash")
        deleteButton.setImage(deleteImage, for: .normal)
        deleteButton.tintColor = .systemGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with post: Post) {
        self.post = post
        titleLabel.text = "#\(post.id). " + post.title
        bodyLabel.text = post.body
        
        let favoriteImage = post.isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(favoriteImage, for: .normal)
        favoriteButton.tintColor = post.isFavorite ? .systemRed : .systemGray
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        delegate?.postCellDidTapFavorite(self, post: self.post)
    }
    
    @IBAction func didTapDeleteButton(_ sender: Any) {
        delegate?.postCellDidTapDelete(self)
    }
}

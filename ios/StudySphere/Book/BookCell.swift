//
//  BookCell.swift
//  StudySphere
//
//  Created by 靳肖阳 on 4/29/23.
//

import UIKit
import Nuke

class BookCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var publishYearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with book: Book) {
        bookNameLabel.text = book.volumeInfo.title
        authorNameLabel.text = book.volumeInfo.authors.joined()
        introLabel.text = book.volumeInfo.description
        publishYearLabel.text = book.volumeInfo.publishedDate

        if let imageUrlString = book.volumeInfo.imageLinks?.smallThumbnail?.replacingOccurrences(of: "http://", with: "https://"),
           let thumbnailUrl = URL(string: imageUrlString) {
            Nuke.loadImage(with: thumbnailUrl, into: bookImageView)
        }
    }
}

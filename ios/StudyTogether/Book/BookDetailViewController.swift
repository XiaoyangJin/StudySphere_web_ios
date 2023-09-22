//
//  BookDetailViewController.swift
//  StudySphere
//
//  Created by 靳肖阳 on 5/1/23.
//

import UIKit
import Nuke

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookCoverImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorlabel: UILabel!
    @IBOutlet weak var bookPublisherLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var bookInfoLabel: UILabel!
    @IBOutlet weak var bookDescLabel: UILabel!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let imageUrlString = book.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://"),
//           let thumbnailUrl = URL(string: imageUrlString) {
//            Nuke.loadImage(with: thumbnailUrl, into: bookCoverImage)
//        }
//        bookNameLabel.text = book.volumeInfo.title
//        bookAuthorlabel.text = book.volumeInfo.authors.joined()
//        bookPublisherLabel.text = book.volumeInfo.publisher
//        publishDateLabel.text = book.volumeInfo.publishedDate
//        bookInfoLabel.text = book.volumeInfo.infoLink
//        bookDescLabel.text = book.volumeInfo.description
        
    }

}

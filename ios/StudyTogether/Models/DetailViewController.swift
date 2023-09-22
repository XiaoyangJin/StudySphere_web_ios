//
//  DetailViewController.swift
//  StudyTogether
//
//  Created by Maheen Khan on 4/18/23.
//

import UIKit
import ParseSwift
import Alamofire
import Nuke


class DetailViewController: UIViewController {
    
    
    var post: Post!
    private var imageDataRequest: DataRequest?
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UITextView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post.title
        usernameLabel.text = post.user?.username
        descLabel.text = post.desc
        bodyTextView.text = post.body
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    self?.detailImageView.image = image
                case .failure(let error):
                    print("❌ Error fetching image: \(error.localizedDescription)")
                    break
                }
            }
        }
    }
}

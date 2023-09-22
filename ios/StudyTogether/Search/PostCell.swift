//
//  PostCell.swift
//  StudyTogether
//
//  Created by Team 24 on 4/17/23.
//

import UIKit
import Nuke
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    private var imageDataRequest: DataRequest?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //selectionStyle = .default
        // Add tap gesture recognizer to the cell
        // let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap))
        // addGestureRecognizer(tapGesture)
    }
    
//    @objc func handleCellTap() {
//        // Perform the segue when the cell is tapped
//        // Replace "yourSegueIdentifier" with the actual segue identifier
//        // and "viewControllerToPresent" with the actual view controller to present
//
//        DetailViewController?.performSegue(withIdentifier: "showPostDetail", sender: SearchViewController)
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with post: Post) {
        // set user
        if let user = post.user {
            userLabel.text = user.username
            print("✅ User Get!")
        }
        
        // set date
        if let date = post.createdAt {
            dateLabel.text = DateFormatter.postFormatter.string(from: date)
        }
        
        // set title & desc
        titleLabel.text = post.title
        descLabel.text = post.desc
        descLabel.textColor = UIColor.systemMint
            
        // set image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                    case .success(let image):
                        self?.posterImage.image = image
                    case .failure(let error):
                        print("❌ Error fetching image: \(error.localizedDescription)")
                        break
                }
            }
        }
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset image view image.
        posterImage.image = nil

        // Cancel image request.
        imageDataRequest?.cancel()
    }
    
}

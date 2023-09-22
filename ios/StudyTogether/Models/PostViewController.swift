//
//  PostViewController.swift
//  StudyTogether
//
//  Created by Maheen Khan on 4/18/23.
//

import UIKit
import PhotosUI
import ParseSwift

class PostViewController: UIViewController {
    
    
   
    @IBOutlet weak var sharedButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    private var pickedImage: UIImage?
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to post", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Error", message: "We need all fields filled out in order for you to post", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onPickedImageTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.preferredAssetRepresentationMode = .current
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        // Present the picker
        present(picker, animated: true)
    }
    
    @IBAction func onShareTapped(_ sender: Any) {
        view.endEditing(true)
        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            return
        }
        
        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        
        var post = Post()
        
        
        post.imageFile = imageFile
        post.title = titleTextField.text
        post.desc = descriptionTextField.text
        post.body = bodyTextView.text
        post.user = User.current
        
        post.save { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    //NotificationCenter.default.post(name: Notification.Name("Posted"), object: nil)
                    print("✅ Post Saved! \(post)")
                    
                    if var currentUser = User.current {
                        
                        currentUser.lastPostedDate = Date()
                        
                        currentUser.save { [weak self] result in
                            switch result {
                            case .success(let user):
                                //NotificationCenter.default.post(name: Notification.Name("Posted"), object: nil)
                                print("✅ User Saved! \(user)")
                                
                                DispatchQueue.main.async {
                                    // Return to previous view controller
                                    self?.navigationController?.popViewController(animated: true)
                                }
                                
                            case .failure(let error):
                                self?.showAlert(description: error.localizedDescription)
                            }
                        }
                    }
                    
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
        
        titleTextField.text?.removeAll()
        previewImage.image = nil
        descriptionTextField.text = "Enter description"
        bodyTextView.text = "Enter Body"
    
    }
        
    @IBAction func onViewTapped(_ sender: Any) {
        view.endEditing(true)
    }
}

extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        // Make sure we have a non-nil item provider
        guard let provider = results.first?.itemProvider,
              // Make sure the provider can load a UIImage
              provider.canLoadObject(ofClass: UIImage.self) else { return }

        // Load a UIImage from the provider
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in

            // Make sure we can cast the returned object to a UIImage
            guard let image = object as? UIImage else {
                self?.showAlert(description: error?.localizedDescription)
                return
            }

            // Check for and handle any errors
            if let error = error {
                self?.showAlert(description: error.localizedDescription)
                return
            } else {
                
                DispatchQueue.main.async {
                    
                    // Set image on preview image view
                    self?.previewImage.image = image
                    
                    // Set image to use when saving post
                    self?.pickedImage = image
                }
            }
        }
    }
}

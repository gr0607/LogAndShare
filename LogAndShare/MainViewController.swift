//
//  MainViewController.swift
//  LogAndShare
//
//  Created by admin on 04.02.2021.
//

import UIKit
import FBSDKShareKit
import VK_ios_sdk


class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func takePhotoPressed(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let ac = UIAlertController(title: "With", message: nil, preferredStyle: .actionSheet)
        
        let actionFacebook = UIAlertAction(title: "Facebook", style: .default, handler: shareWithFacebook)
        let actionVK = UIAlertAction(title: "VKontakte", style: .default, handler: shareWithVK)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        ac.addAction(actionFacebook)
        ac.addAction(actionVK)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return}
        self.dismiss(animated: true, completion: nil)
        photoImage.image = image
    }
    
    func shareWithFacebook(action: UIAlertAction) {
        guard let image = photoImage.image else { return }
        let photo = SharePhoto(image: image, userGenerated: true)
        let photoContent = SharePhotoContent()
        photoContent.photos = [photo]
        
        let sharingDialog = ShareDialog.init(fromViewController: self, content: photoContent, delegate: nil)
        
        sharingDialog.show()
    }
    
    func shareWithVK(action: UIAlertAction) {
        guard let image = photoImage.image else { return }
        let shareDialog = VKShareDialogController()
        
        shareDialog.uploadImages =  [VKUploadImage(image: image, andParams: VKImageParameters.pngImage())]
       
        shareDialog.completionHandler = { controller, result in
            self.dismiss(animated: true, completion: nil)
        }
        
        present(shareDialog, animated: true, completion: nil)
    }
}

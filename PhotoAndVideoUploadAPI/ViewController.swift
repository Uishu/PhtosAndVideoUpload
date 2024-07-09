//
//  ViewController.swift
//  PhotoAndVideoUploadAPI
//
//  Created by Disha on 09/07/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func pickMedia(_ sender: Any) {
        let alert = UIAlertController(title: "Select Media", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo", style: .default, handler: { _ in
            self.pickPhoto()
        }))
        alert.addAction(UIAlertAction(title: "Video", style: .default, handler: { _ in
            self.pickVideo()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func pickPhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickVideo() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            uploadMedia(file: image, fileType: "Photos")
        } else if let videoUrl = info[.mediaURL] as? URL {
            uploadMedia(file: videoUrl, fileType: "Videos")
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



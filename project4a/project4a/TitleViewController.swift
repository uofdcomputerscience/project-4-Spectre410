//
//  TitleViewController.swift
//  project4a
//
//  Created by Matt Pritchett on 12/15/19.
//  Copyright © 2019 Matt Pritchett. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {
    var userImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func imagePickerTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        present(vc,animated: true, completion: nil)
        
        if userImage != nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            vc.image = userImage
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TitleViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        
        userImage = image
        
        dismiss(animated: true, completion: nil)
    }
}

extension TitleViewController: UINavigationControllerDelegate {
    
}

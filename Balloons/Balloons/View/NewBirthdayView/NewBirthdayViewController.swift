//
//  NewBirthdayViewController.swift
//  Balloons
//
//  Created by Brena Amorim on 09/02/21.
//

import UIKit

class NewBirthdayViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newBirthday: NewBirthdayView = {
        let view = NewBirthdayView()
        return view
    }()
    
    override func loadView() {
        view = newBirthday
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adicionar Aniversário"
        configureNavBar()
        newBirthday.editImageButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
    }
    
    func configureNavBar() {
        // navBar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.tintColor = UIColor.actionColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissNB))
    }

    @objc func save() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func dismissNB() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))

        self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        newBirthday.personImage.image = image

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

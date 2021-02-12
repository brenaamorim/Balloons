//
//  NewBirthdayViewController.swift
//  Balloons
//
//  Created by Brena Amorim on 09/02/21.
//

import UIKit

class NewBirthdayViewController: UIViewController, UITextFieldDelegate {

    let birthdayViewModel = NewBirthdayViewModel()
    let imagePickerController = UIImagePickerController()
    let destination = InitialViewController()

//    var delegate: DataSource?
    
    var newBirthday: NewBirthdayView = {
        let view = NewBirthdayView()
        return view
    }()
    
    override func loadView() {
        view = newBirthday
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let readAll = birthdayViewModel.reloadDataSource()
        passBirthday(data: readAll)
//        let vc2 = InitialViewController()
//        vc2.delegate = self
//        vc2.delegate!.passBirthday(data: readAll)
        print("NewBirthday")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adicionar Aniversário"
        newBirthday.nameLabel.delegate = self
        newBirthday.numberLabel.delegate = self

        configureNavBar()

        self.hideKeyboardWhenTappedAround()
    
        newBirthday.editImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
    }
    
    func configureNavBar() {
        // navBar transparent
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.tintColor = UIColor.actionColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissNB))
    }
    
    func captureUserEntry() -> BirthdayBiding? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        // png is personImage BinaryData
        let photo = newBirthday.personImage.image?.pngData()
        let name = newBirthday.nameLabel.text!
        guard let birth = newBirthday.birthDate.text else {return nil}
        let phoneNumber = newBirthday.numberLabel.text!

        //Unwrap birthDate and converting to NSDate
        if  let birthDate: NSDate = (dateFormatter.date(from: birth) as NSDate?) {
            let dataBirthday = BirthdayBiding(photo: photo!, name: name, birth: birthDate as Date, phoneNumber: phoneNumber)

            return dataBirthday
        }

        return nil
    }
    
    // Save on CoreData
    @objc func save() {
        if let birthday = captureUserEntry() {
            if self.birthdayViewModel.saveBirthday(birthday: birthday) {
                print("Birthday saved!")
            } else {
                let alert = UIAlertController(title: "Ops!", message: "Ocorreu um erro ao adicionar um aniversário", preferredStyle: .alert)
                let dismissAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(dismissAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissNB() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectImage() {
        openImagePicker()
    }

    // Limit number of characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 24
        
        if textField.keyboardType == UIKeyboardType.phonePad {
            maxLength = 11
        }

        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

}

// Hide Keybord when finish editing
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// Trying to delegate D:
extension NewBirthdayViewController: DataSource {
    func passBirthday(data: [Birthday]) {
        destination.dataSource = data
        
        present(destination, animated: true, completion: nil)
    }
}

// Defining source type for friends image
extension NewBirthdayViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
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

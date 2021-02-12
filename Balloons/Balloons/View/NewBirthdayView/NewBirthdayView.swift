//
//  CreateBirthday.swift
//  Balloons
//
//  Created by Brena Amorim on 09/02/21.
//

import UIKit

class NewBirthdayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var backgroundImage: UIImageView = {
       let bgimage = UIImageView()
        bgimage.translatesAutoresizingMaskIntoConstraints = false
        bgimage.backgroundColor = .clear
        bgimage.image = UIImage(named: "backgroundImage")
        bgimage.contentMode = .scaleAspectFill
        return bgimage
    }()

    lazy var nameView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 27
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
    lazy var editImageButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Editar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.contentVerticalAlignment = .bottom
        button.contentHorizontalAlignment = .center
        button.setTitleColor(UIColor.actionColor, for: UIControl.State())
        button.backgroundColor = .clear
        return button
    }()

    lazy var personImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.image = UIImage(named: "emojiBirthday")
        image.layer.cornerRadius = 58
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    lazy var personIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "person.fill")
        icon.tintColor = .textColor
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var nameLabel: UITextField = {
        var name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.placeholder = "Nome"
        name.textColor = .textColor
        name.font = .systemFont(ofSize: 20, weight: .regular)
        return name
    }()
    
    lazy var birthView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 27
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
    lazy var birthIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(named: "cake")
        icon.tintColor = .textColor
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var birthDate: UITextField = {
        var date = UITextField()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.tintColor = .clear
        date.placeholder = "Aniversário"
        date.tintColor = .clear
        date.textColor = .textColor
        date.inputView = generatePicker()
        date.font = .systemFont(ofSize: 20, weight: .regular)
        return date
    }()
    
    lazy var numberView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 27
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
    lazy var numberIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "phone.fill")
        icon.tintColor = .textColor
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    lazy var numberLabel: UITextField = {
        var name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.keyboardType = UIKeyboardType.phonePad
        name.placeholder = "Telefone"
        name.textColor = .textColor
        name.font = .systemFont(ofSize: 20, weight: .regular)
        return name
    }()
    
    private func generatePicker() -> UIView {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "pt_BR")
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        return datePicker
    }
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        birthDate.text = dateFormatter.string(from: datePicker.date)
    }

    func setupConstraints() {

        self.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.addSubview(personImage)
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 122),
            personImage.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            personImage.widthAnchor.constraint(equalToConstant: 116),
            personImage.heightAnchor.constraint(equalToConstant: 116)
        ])
        
        self.addSubview(editImageButton)
        NSLayoutConstraint.activate([
            editImageButton.topAnchor.constraint(equalTo: personImage.topAnchor),
            editImageButton.leadingAnchor.constraint(equalTo: personImage.leadingAnchor),
            editImageButton.trailingAnchor.constraint(equalTo: personImage.trailingAnchor),
            editImageButton.bottomAnchor.constraint(equalTo: personImage.bottomAnchor)
        ])

        self.addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: 48),
            nameView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameView.heightAnchor.constraint(equalToConstant: 56),
            nameView.widthAnchor.constraint(lessThanOrEqualTo: nameView.heightAnchor, multiplier: 6.0)
        ])

        self.addSubview(personIcon)
        NSLayoutConstraint.activate([
            personIcon.centerYAnchor.constraint(equalTo: nameView.centerYAnchor),
            personIcon.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: 24),
            personIcon.widthAnchor.constraint(equalToConstant: 28),
            personIcon.heightAnchor.constraint(equalToConstant: 24)
        ])

        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: personIcon.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: personIcon.trailingAnchor, constant: 8),
            nameLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        self.addSubview(birthView)
        NSLayoutConstraint.activate([
            birthView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 24),
            birthView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            birthView.heightAnchor.constraint(equalToConstant: 56),
            birthView.widthAnchor.constraint(lessThanOrEqualTo: birthView.heightAnchor, multiplier: 6.0)
        ])
        
        self.addSubview(birthIcon)
        NSLayoutConstraint.activate([
            birthIcon.centerYAnchor.constraint(equalTo: birthView.centerYAnchor),
            birthIcon.leadingAnchor.constraint(equalTo: birthView.leadingAnchor, constant: 24),
            birthIcon.widthAnchor.constraint(equalToConstant: 28),
            birthIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        self.addSubview(birthDate)
        NSLayoutConstraint.activate([
            birthDate.topAnchor.constraint(equalTo: birthIcon.topAnchor),
            birthDate.leadingAnchor.constraint(equalTo: birthIcon.trailingAnchor, constant: 8),
            birthDate.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        self.addSubview(numberView)
        NSLayoutConstraint.activate([
            numberView.topAnchor.constraint(equalTo: birthView.bottomAnchor, constant: 24),
            numberView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            numberView.heightAnchor.constraint(equalToConstant: 56),
            numberView.widthAnchor.constraint(lessThanOrEqualTo: numberView.heightAnchor, multiplier: 6.0)
        ])

        self.addSubview(numberIcon)
        NSLayoutConstraint.activate([
            numberIcon.centerYAnchor.constraint(equalTo: numberView.centerYAnchor),
            numberIcon.leadingAnchor.constraint(equalTo: numberView.leadingAnchor, constant: 24),
            numberIcon.widthAnchor.constraint(equalToConstant: 28),
            numberIcon.heightAnchor.constraint(equalToConstant: 24)
        ])

        self.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: numberIcon.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: numberIcon.trailingAnchor, constant: 8),
            numberLabel.widthAnchor.constraint(equalToConstant: 300)
        ])

    }
    
}

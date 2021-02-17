//
//  InitialTableViewCell.swift
//  Balloons
//
//  Created by Brena Amorim on 08/02/21.
//

import UIKit

class InitialTableViewCell: UITableViewCell {
    
    // Inicialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContraints()
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowOpacity = 0.4
        cardView.frame = CGRect(x: 0, y: 0, width: 382, height: 153)
        return cardView
    }()
    
    lazy var personImage: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        let rect = CGRect(x: 0, y: 0, width: 86, height: 86)
//        image.image?.draw(in: rect)
        image.backgroundColor = .clear
        image.layer.masksToBounds = true
        // Deixa a imagem circular
        image.layer.cornerRadius = 43
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var name: UILabel = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = " "
        name.minimumScaleFactor = 0.7
        name.numberOfLines = 0
        name.textColor = .textColor
        name.textAlignment = .left
        name.font = .roundedFont(ofSize: 28, weight: .semibold)
        return name
    }()
    
    lazy var age: UILabel = {
        var age = UILabel()
        age.translatesAutoresizingMaskIntoConstraints = false
        age.text = " "
        age.textColor = .textColor
        age.font = .systemFont(ofSize: 22, weight: .light)
        return age
    }()

    lazy var separator: UILabel = {
        let separator = UILabel()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.text = "|"
        separator.textColor = .textColor
        separator.font = .systemFont(ofSize: 22, weight: .light)
        return separator
    }()
    
    lazy var birthday: UILabel = {
        var birthday = UILabel()
        birthday.translatesAutoresizingMaskIntoConstraints = false
        birthday.text = " "
        birthday.textColor = .textColor
        birthday.font = .systemFont(ofSize: 22, weight: .light)
        return birthday
    }()
    
    func setupContraints() {
        
        self.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalToConstant: 153)
        ])
        
        self.addSubview(personImage)
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 34),
            personImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            personImage.heightAnchor.constraint(equalToConstant: 86),
            personImage.widthAnchor.constraint(equalToConstant: 86)
        ])
        
        self.addSubview(name)
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: personImage.topAnchor, constant: 12),
            name.leadingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 16)
        ])
        
        self.addSubview(age)
        NSLayoutConstraint.activate([
            age.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            age.leadingAnchor.constraint(equalTo: name.leadingAnchor)
        ])

        self.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo: age.topAnchor),
            separator.leadingAnchor.constraint(equalTo: age.trailingAnchor, constant: 5)
        ])

        self.addSubview(birthday)
        NSLayoutConstraint.activate([
            birthday.topAnchor.constraint(equalTo: separator.topAnchor),
            birthday.leadingAnchor.constraint(equalTo: separator.trailingAnchor, constant: 5)
        ])

    }
    
}

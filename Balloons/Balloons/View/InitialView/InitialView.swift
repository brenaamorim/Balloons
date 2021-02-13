//
//  InitialView.swift
//  Balloons
//
//  Created by Brena Amorim on 08/02/21.
//

import UIKit

class InitialView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
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
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 181
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(InitialTableViewCell.self, forCellReuseIdentifier: "InitialTableViewCell")
        return tableView
    }()
    
    lazy var monthView: UIView = {
       var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.4
        return view
    }()
    
    lazy var monthLabel: UILabel = {
        var name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        
        var dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "pt_BR")
        let month = calendar.component(.month, from: Date())
        let monthName = dateFormatter.monthSymbols[month - 1]

        name.text = monthName.capitalizingFirstLetter()
        name.textColor = .textColor
        name.font = .roundedFont(ofSize: 28, weight: .bold)
        return name
    }()

    func setupConstraints() {

        self.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.addSubview(monthView)
        NSLayoutConstraint.activate([
            monthView.topAnchor.constraint(equalTo: self.topAnchor, constant: 148),
            monthView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 14),
            monthView.widthAnchor.constraint(equalToConstant: 161),
            monthView.heightAnchor.constraint(equalToConstant: 34)
        ])

        self.addSubview(monthLabel)
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: monthView.topAnchor),
            monthLabel.centerXAnchor.constraint(equalTo: monthView.centerXAnchor)
        ])

        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: monthView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

    }
    
}

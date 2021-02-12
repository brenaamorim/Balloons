//
//  ViewController.swift
//  Balloons
//
//  Created by Brena Amorim on 08/02/21.
//

import UIKit

class InitialViewController: UIViewController, DataSource {

    var dataSource = [Birthday]()
    let initialViewModel: InitialViewModel = InitialViewModel()

    var initialView: InitialView = {
        let view = InitialView()
        return view
    }()

    override func loadView() {
        view = initialView
        configureTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Aniversariantes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        let vc2 = NewBirthdayViewController()
//        vc2.delegate = self
        self.initialView.tableView.reloadData()
    }

    func passBirthday(data: [Birthday]) {
        self.dataSource = data
        self.initialView.tableView.reloadData()
        print("InitialView")
    }

    @objc func addTapped () {
        // modal present with navigation
        let navController = UINavigationController(rootViewController: NewBirthdayViewController())
        self.present(navController, animated: true, completion: nil)
    }

    func configureTableView() {
        initialView.tableView.delegate = self
        initialView.tableView.dataSource = self
    }

}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialViewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = initialView.tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell") as? InitialTableViewCell else {
            return InitialTableViewCell()
        }

        let data = initialViewModel.getAllCellsData()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: data[indexPath.row].birthDate!)
        let month = calendar.component(.month, from: data[indexPath.row].birthDate!)
        let monthName = dateFormatter.monthSymbols[month - 1]
        let year = calendar.component(.year, from: data[indexPath.row].birthDate!)
        let currentMonth = calendar.component(.month, from: Date())

        if month == currentMonth {
            if let image = data[indexPath.row].photo {
                let getImage = UIImage(data: image)
//                image.

                cell.personImage.image = getImage
                cell.name.text = data[indexPath.row].name
                cell.birthday.text = String(day) + " " + String(monthName)
                cell.age.text = String(initialViewModel.calculateAge(year: Int(year))) + " anos"
            }
        }

        return cell
    }

}

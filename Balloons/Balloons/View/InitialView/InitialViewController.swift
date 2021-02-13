//
//  ViewController.swift
//  Balloons
//
//  Created by Brena Amorim on 08/02/21.
//

import UIKit

class InitialViewController: UIViewController {

    var getBirthdays = [Birthday]()
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
        
        getBirthdays = initialViewModel.reloadDataSource()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }

    @objc func addTapped () {
        // modal present with navigation
        
        let newBirthdayVC = NewBirthdayViewController()
        newBirthdayVC.delegate = self
        let navController = UINavigationController(rootViewController: newBirthdayVC)
        self.present(navController, animated: true, completion: nil)
    }

    func configureTableView() {
        initialView.tableView.delegate = self
        initialView.tableView.dataSource = self
    }

}

extension InitialViewController: BirthdayDelegate {

    func passBirthdayData() {
        getBirthdays = initialViewModel.reloadDataSource()
        initialView.tableView.reloadData()
        print("Data Reload!")
    }

}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getBirthdays.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = initialView.tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell") as? InitialTableViewCell else {
            return InitialTableViewCell()
        }

        let data = getBirthdays
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

//                let imgeUp = getImage?.fixOrientation(img: getImage!)
                cell.personImage.image = getImage
                cell.name.text = data[indexPath.row].name
                cell.birthday.text = String(day) + " " + String(monthName)
                cell.age.text = String(initialViewModel.calculateAge(year: Int(year))) + " anos"
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = NewBirthdayViewController()
        let navController = UINavigationController(rootViewController: controller)

        guard let cellData = initialViewModel.getCellData(forIndex: indexPath.row, birthdays: getBirthdays) else { return }
        controller.birthdayViewModel.birthdayData = cellData

        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()

            guard let birthdayId = getBirthdays[indexPath.row].id else {return}
            _ = initialViewModel.deleteBirthday(identifier: birthdayId)
            getBirthdays = initialViewModel.reloadDataSource()
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.endUpdates()
                
        }
    
    }

}

//
//  ViewController.swift
//  Balloons
//
//  Created by Brena Amorim on 08/02/21.
//

import UIKit

class InitialViewController: UIViewController {
    
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
    }
    
    func configureTableView() {
        initialView.tableView.delegate = self
        initialView.tableView.dataSource = self
    }

}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = initialView.tableView.dequeueReusableCell(withIdentifier: "InitialTableViewCell") as? InitialTableViewCell else {
            return InitialTableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("celula selecionada")
    }

}

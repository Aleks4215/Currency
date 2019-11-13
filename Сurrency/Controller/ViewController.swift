//
//  ViewController.swift
//  Сurrency
//
//  Created by Алексей Евменьков on 9/8/19.
//  Copyright © 2019 MyCompany. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    private let identifier = "mycell"
    private let outputIdentifier = "output"
    private let refreshConrol = UIRefreshControl()
    private var myCurrency: Response?
    private var data = 0.0
    var new = 0.0
    //MARK:- Update data
    private func updateData() {
        NetworkManager.shared.getCurrentCurrency {
            (myCurrency) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let textUpdate = "Update"
                self.refreshConrol.attributedTitle = NSAttributedString(string: textUpdate)
                self.refreshConrol.addTarget(self, action: #selector(self.updateTable), for: .valueChanged)
                self.tableView.refreshControl = self.refreshConrol
            }
        }
    }
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getCurrentCurrency {
            (myCurrency) in
            self.myCurrency = myCurrency
        }
        updateData()
        tableView.tableFooterView = UIView()
        
        tableView?.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView?.register(UINib(nibName: "OutputTableViewCell", bundle: nil), forCellReuseIdentifier: outputIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        CoreDataHelper.coreDatHelper.saveValue(value: 99.00)
        CoreDataHelper.coreDatHelper.fetchValue(complition: {
            (data) in
            print(data)
        })
        CoreDataHelper.coreDatHelper.timeCheker()
    }
    //MARK: - Update data
    @objc private func updateTable() {
        NetworkManager.shared.getCurrentCurrency {
            (myCurrency) in
            self.myCurrency = myCurrency
            print("Update")
        }
        refreshConrol.endRefreshing()
        tableView.reloadData()
    }
    
    
}
//MARK: - UITableView Delegates
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell
                else {
                    return defaultCell
            }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: outputIdentifier) as? OutputTableViewCell else {
                return defaultCell
            }
            cell.setupUsd(data)
            
            return cell
        default:
            break
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension ViewController: PassTextDelegate {
    func passText(text: String?) {
        guard let currentText = text, let rate = myCurrency?.usd_byn else {
            return
        }
        if currentText == "" {
            data = 0.0
            tableView.reloadRows(at: [IndexPath(item:1 , section: 0)], with: .none)
        }
        guard let sum = Double(currentText) else { return }
        let result = sum / rate
        data = result
        tableView.reloadRows(at: [IndexPath(item:1 , section: 0)], with: .none)
    }
}

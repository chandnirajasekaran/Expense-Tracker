//
//  DataViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/22/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import RealmSwift
import UIKit
import Firebase



class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let realm = try! Realm()
    private var data = [PurchaseItems]()
    
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async { [weak self] in
                self?.navigationController?.navigationBar.sizeToFit()
            }
    }
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.viewWillAppear(true)
        super.viewDidLoad()
        data = realm.objects(PurchaseItems.self).map( {$0} )
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (data.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "$" + data[indexPath.row].price + "    " + data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]
        guard let vc = storyboard?.instantiateViewController(identifier: "edit") as? EditViewController else {
            return
        }
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.title = item.item
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }

    @IBAction func addButtonTapped() {
        guard let vc = storyboard?.instantiateViewController(identifier: "formScreen") as? FormViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
        }
        
        vc.title = "New Purchase Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func refresh() {
        data = realm.objects(PurchaseItems.self).map( {$0} )
        tableView.reloadData()
    }

}

//
//  EditViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/24/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import RealmSwift
import UIKit

class EditViewController: UIViewController {

    public var item: PurchaseItems?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var  itemLabel: UILabel!
    @IBOutlet var  priceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        super.viewDidLoad()
        itemLabel.text = item!.item
        priceLabel.text = "$" + item!.price
        dateLabel.text = Self.dateFormatter.string(from: item!.date)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func deleteTapped() {
        guard let currentItem = self.item else{
            return
        }
        realm.beginWrite()
        realm.delete(currentItem)
        try! realm.commitWrite()
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }

}

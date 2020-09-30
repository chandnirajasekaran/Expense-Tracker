//
//  SummaryViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/25/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import UIKit
import RealmSwift

class SummaryViewController: UIViewController {
    
    private var data = [PurchaseItems]()
    private let realm = try! Realm()
    @IBOutlet var  totalPrice: UILabel!
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        data = realm.objects(PurchaseItems.self).map( {$0} )
        var sum = 0.00;
        for item in data {
            sum += Double(item.price)!
        }
        totalPrice.text = "$" + String(format: "%.2f", sum)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

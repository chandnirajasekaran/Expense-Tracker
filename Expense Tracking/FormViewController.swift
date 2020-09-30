//
//  FormViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/23/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import RealmSwift
import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        priceField.becomeFirstResponder()
        priceField.delegate = self
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM yyyy"
                let selectedDate = dateFormatter.string(from: datePicker.date)
                print(selectedDate)
        datePicker.setDate(Date(), animated: true)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveButtonTapped))
        // Do any additional setup after loading the view.
    }
    
    func priceFieldShouldReturn(_ textField: UITextField) -> Bool {
        priceField.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func saveButtonTapped() {
        if let text =  textField.text, !text.isEmpty{
            let date = datePicker.date
            let price = priceField.text
            realm.beginWrite()
            let newItem = PurchaseItems()
            newItem.date = date
            newItem.price = price ?? "0.00"
            newItem.item = text
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            print("Add Something")
        }
    }
    
}

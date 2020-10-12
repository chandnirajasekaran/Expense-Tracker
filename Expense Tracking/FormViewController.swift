//
//  FormViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/23/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import Firebase
import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    public var completionHandler: (() -> Void)?
    var db =  Firestore.firestore()
  
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
            let formatter1 = DateFormatter()
            formatter1.dateStyle = .medium
            let date = formatter1.string(from: datePicker.date)
            let price = priceField.text
            let newItem = PurchaseItems()
            newItem.date = date
            newItem.price = price ?? "0.00"
            if(Auth.auth().currentUser?.email == nil) {
                print("setting")
                let newDocument = db.collection("googleUser").document()
                newDocument.setData(["text":text, "price": price!, "id": newDocument.documentID, "date": date])
                newItem.docId = newDocument.documentID
            } else {
                let newDocument = db.collection(Auth.auth().currentUser!.email!).document()
                newDocument.setData(["text":text, "price": price!, "id": newDocument.documentID, "date": date])
                newItem.docId = newDocument.documentID
            }
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        } else {
            print("Add Something")
        }
    }
    
}

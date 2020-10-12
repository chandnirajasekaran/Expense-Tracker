//  SummaryViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/25/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//
import UIKit
import Firebase

class SummaryViewController: UIViewController {
    
    private var data = [PurchaseItems]()
    @IBOutlet var  totalPrice: UILabel!
    
    var db =  Firestore.firestore()
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        var sumTotal:Double = 0
        if(Auth.auth().currentUser?.email == nil) {
            db.collection("googleUser").getDocuments { [self] (snapshot, err) in
                  if let err = err {
                      print("Error getting documents: \(err)")
                  } else {
                      for document in snapshot!.documents {
                        let temp = document.get("price") as! String
                        sumTotal = sumTotal + Double(temp)!
                      }
                  
                  }
            totalPrice.text = "$" + String(format: "%.2f", sumTotal)
            viewDidLoad()
            }
        } else {
            db.collection((Auth.auth().currentUser?.email!)!).getDocuments { [self] (snapshot, err) in
                  if let err = err {
                      print("Error getting documents: \(err)")
                  } else {
                      for document in snapshot!.documents {
                        let temp = document.get("price") as! String
                        sumTotal = sumTotal + Double(temp)!
                      }
                  
                  }
                totalPrice.text = "$" + String(format: "%.2f", sumTotal)
                viewDidLoad()
            }
        }
    }
    
}

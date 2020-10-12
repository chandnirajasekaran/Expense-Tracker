//
//  EditViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/24/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {

    public var item: PurchaseItems?
    
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var  itemLabel: UILabel!
    @IBOutlet var  priceLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var db =  Firestore.firestore()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    var itemId = "temporary"
    
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        super.viewDidLoad()
        itemLabel.text = item!.item
        priceLabel.text = "$" + item!.price
        dateLabel.text = item!.date
        itemId = item!.docId
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTapped))
        // Do any additional setup after loading the view.
    }
    
    
    @objc private func deleteTapped() {
        guard let currentItem = self.item else{
            return
        }
        if(Auth.auth().currentUser?.email == nil) {
            db.collection("googleUser").document(itemId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            
        } else {
            db.collection(Auth.auth().currentUser!.email!).document(itemId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tab")
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }

}

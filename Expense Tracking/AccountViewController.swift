//
//  AccountViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/26/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class AccountViewController: UIViewController {
    
    @IBOutlet var accountEmail: UILabel!
    var emailAccount = ""

    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        if(Auth.auth().currentUser?.email == nil) {
            accountEmail.text = "Google Account"
        } else {
            accountEmail.text = Auth.auth().currentUser!.email!
        
        }
        super.viewDidLoad()
    }

    @IBAction func logOutTapped(_ sender: Any) {
        if(Auth.auth().currentUser?.email == nil) {
            GIDSignIn.sharedInstance()?.signOut()
        } else {
        print("INSIDE HEHEHEH")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
        }
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    

}

//
//  SignupViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/17/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        if email.text?.isEmpty == true {
            print("No text in email field")
            // ADD ALERT VIEW to notify that field is wrong
            return
        }
        if password.text?.isEmpty == true {
            print("No text in password field")
            // ADD ALERT VIEW to notify that field is wrong
            return
        }
        signUP()
    }
    
   
    
    @IBAction func alreadyHaveAccountLoginTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func signUP() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                print("Error \(error?.localizedDescription)")
                return
            }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "accountCreated")
                vc?.modalPresentationStyle = .overFullScreen
                self.present(vc!, animated: true)
        }
    }
}

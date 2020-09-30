//
//  AccountedCreatedViewController.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/18/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import UIKit

class AccountedCreatedViewController: UIViewController {

    override func viewDidLoad() {
        view.setGradientBackground(colorOne: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0), colorTwo: UIColor(red:109.0/255.0, green: 107.0/255.0, blue:107.0/255.0, alpha:1.0), colorThree: UIColor(red:70.0/255.0, green: 67.0/255.0, blue:66.0/255.0, alpha:1.0))
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnToLoginTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "login")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}

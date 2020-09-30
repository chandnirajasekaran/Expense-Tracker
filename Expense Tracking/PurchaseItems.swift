//
//  PurchaseItems.swift
//  Expense Tracking
//
//  Created by Chandni Rajasekaran on 9/25/20.
//  Copyright © 2020 Chandni Rajasekaran. All rights reserved.
//

import RealmSwift
import UIKit
import Foundation
import Firebase

class PurchaseItems: Object {
    @objc dynamic var price: String = ""
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()
}

//
//  ViewController.swift
//  CustomNotification
//
//  Created by Phi Van Tuan on 01/08/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let notifyBuilder = TestNotificationBuilder()
    let swiftUIController = UIHostingController(rootView: ListView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func showNotify(_ sender: UIButton) {
        notifyBuilder.showNotification()
    }
    
}


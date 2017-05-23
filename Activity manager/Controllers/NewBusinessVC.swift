//
//  NewBusinessVC.swift
//  Activity manager
//
//  Created by Giancarlo Valencia on 5/23/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit

class NewBusinessVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var personTextField: UITextField!
    @IBOutlet weak var personPicker: UIPickerView!
    
    @IBOutlet weak var organizationTextField: UITextField!
    @IBOutlet weak var organizationPicker: UIPickerView!

    @IBOutlet weak var pricingTextField: UITextField!
    
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
    }

    @IBAction func saveAction(_ sender: Any) {
    }

}

//
//  ViewController.swift
//  Activity manager
//
//  Created by Mario Vizcaino on 5/22/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator

class LoginVC: UIViewController, ValidationDelegate, UITextFieldDelegate {

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpValidations()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(LoginVC.hideKeyboard)))

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func forgotUserAction() {
    }
    
    @IBAction func loginAction() {
        validator.validate(self)
    }
    
    func validationSuccessful() {
        if (userTextField.text == "nativapps" && passwordTextField.text == "12345") {
            
        }else{
        }
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
    
    func setUpValidations() {
        validator.styleTransformers(success:{ (validationRule) -> Void in
            if let textField = validationRule.field as? UITextField {
                textField.layer.borderColor = UIColor.green.cgColor
                textField.layer.borderWidth = 0.5
                
            }
        }, error:{ (validationError) -> Void in
            if let textField = validationError.field as? UITextField {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            }
        })
        
        validator.registerField(userTextField, rules: [RequiredRule()])
        validator.registerField(passwordTextField, rules: [RequiredRule()])

    }
    func hideKeyboard(){
        self.view.endEditing(true)
    }
    
}


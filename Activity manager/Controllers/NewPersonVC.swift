//
//  NewPersonVC.swift
//  Activity manager
//
//  Created by Giancarlo Valencia on 5/22/17.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import UIKit
import SwiftValidator


class NewPersonVC: UIViewController, ValidationDelegate, UITextFieldDelegate  {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    
    let validator = Validator()

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personService: PersonService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValidations()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(LoginVC.hideKeyboard)))
        personService = PersonService(context: managedContext)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        backAction()
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        validator.validate(self)
        
        
    }

}
extension NewPersonVC{
    func backAction() {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: {
            let p = PersonVC()
            p.refreshTable()
        })

    }
    func validationSuccessful() {
        var phone: NSNumber!
        if let myInteger = Int(phoneTextField.text!) {
            phone = NSNumber(value:myInteger)
        }
        
        _ = personService.create(name: nameTextField.text!, phone: phone, email: emailtextField.text!)
        personService.saveChanges()
        backAction()
    }
    
    func validationFailed(_ errors:[(Validatable ,ValidationError)]) {
        // turn the fields to red
        for (field, _) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
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
        validator.registerField(nameTextField, rules: [RequiredRule()])
        validator.registerField(emailtextField, rules: [RequiredRule(), EmailRule()])
        validator.registerField(phoneTextField, rules: [RequiredRule(), PhoneNumberRule()])
        
    }
}

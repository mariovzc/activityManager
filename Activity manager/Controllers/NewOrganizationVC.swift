import Foundation
import UIKit
import SwiftValidator


class NewOrganizationVC: UIViewController, ValidationDelegate {

    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    let validator = Validator()
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var organizationService: OrganizationService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpValidations()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(LoginVC.hideKeyboard)))
        organizationService = OrganizationService(context: managedContext)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
    }

    @IBAction func saveOrganization(_ sender: Any) {
        validator.validate(self)

    }

}

extension NewOrganizationVC{
    func backAction() {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion:nil)
        
    }
    func validationSuccessful() {
        var phone: NSNumber!
        if let myInteger = Int(phoneTextField.text!) {
            phone = NSNumber(value:myInteger)
        }
        
        _ = organizationService.create(name: nameTextfield.text!, phone: phone, address: addressTextField.text!)
        organizationService.saveChanges()
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
        validator.registerField(nameTextfield, rules: [RequiredRule()])
        validator.registerField(addressTextField, rules: [RequiredRule()])
        validator.registerField(phoneTextField, rules: [RequiredRule(), PhoneNumberRule()])
        
    }
}

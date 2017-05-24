import UIKit

class NewActivity: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var personPicker: UIPickerView!
    
    @IBOutlet weak var businessPicker: UIPickerView!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var organizationPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    @IBAction func saveAction(_ sender: Any) {
    }
}

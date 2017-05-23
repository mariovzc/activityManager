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
    
    var date: Date!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var personService: PersonService!
    var people : [Person] = []
    var selectedPerson = 0
    
    var organizationService: OrganizationService!
    var organizations : [Organization] = []
    var selectedOrganization = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialData()
        date = datePicker.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        back()
    }

    @IBAction func saveAction(_ sender: Any) {
    }
    
    @IBAction func showPeoplePicker(_ sender: UIButton) {
        hidePickers()
        personPicker.isHidden = false
    }
    @IBAction func showOrganizationPicker(_ sender: UIButton) {
        hidePickers()
        organizationPicker.isHidden = false
    }
}
extension NewBusinessVC{
    func initialData() {
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        date = datePicker.date
        
        personService = PersonService(context: managedContext)
        people = personService.getAll()
        personTextField.text = people.first?.name
        
        organizationService = OrganizationService(context: managedContext)
        organizations = organizationService.getAll()
        organizationTextField.text = organizations.first?.name
        
        hidePickers()
        
        
        descriptionTextView.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.cornerRadius = 5
    }
    func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
    }
    func hidePickers(){
        personPicker.isHidden = true
        organizationPicker.isHidden = true
    }

}

//Pickers methods
extension NewBusinessVC: UIPickerViewDelegate, UIPickerViewDataSource{
    //this get the datepicker value
    func dateChanged(_ sender: UIDatePicker) {
        date = datePicker.date
        print(datePicker.date)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == personPicker{
            return people.count
        }else{
            return organizations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == personPicker{
            return people[row].name
        }else{
            return organizations[row].name
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == personPicker{
            personTextField.text = people[row].name
            selectedPerson = row
        }else{
            organizationTextField.text = organizations[row].name
            selectedOrganization = row
        }

    }
}

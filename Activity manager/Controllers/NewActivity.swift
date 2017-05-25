import UIKit

class NewActivity: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    
    @IBOutlet weak var personPicker: UIPickerView!
    
    @IBOutlet weak var businessPicker: UIPickerView!
    
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var organizationPicker: UIPickerView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var date: Date!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var personService: PersonService!
    var people: [Person] = []
    var selectedPerson = 0
    
    var organizationService: OrganizationService!
    var organizations: [Organization] = []
    var selectedOrganization = 0
    
    var businessService: BusinessService!
    var business: [Business] = []
    var selectedBusiness = 0
    //let validator = Validator()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialData()
        date = datePicker.date
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(hideKeyboard)))
        //setUpValidations()

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
extension NewActivity{

    func initialData() {
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        date = datePicker.date
        
        personService = PersonService(context: managedContext)
        people = personService.getAll()
        //personTextField.text = people.first?.name
        
        organizationService = OrganizationService(context: managedContext)
        organizations = organizationService.getAll()
        //organizationTextField.text = organizations.first?.name
        
        businessService = BusinessService(context: managedContext)
        business = businessService.getAll()
        hidePickers()
        
        descTextView.layer.borderColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        descTextView.layer.borderWidth = 0.5
        descTextView.layer.cornerRadius = 5
    }
    func hideKeyboard(){
        self.view.endEditing(true)
        hidePickers()
    }
    
    func back(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion:nil)
    }
    func hidePickers(){
        personPicker.isHidden = true
        organizationPicker.isHidden = true
        businessPicker.isHidden = true
    }
}

extension NewActivity: UIPickerViewDelegate, UIPickerViewDataSource{
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
        }else if pickerView == businessPicker{
            return business.count
        }else{
            return organizations.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == personPicker{
            return people[row].name
        }else if pickerView == businessPicker{
            return business[row].tittle
        }else{
            return organizations[row].name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == personPicker{
            //personTextField.text = people[row].name
            selectedPerson = row
        }else if pickerView == businessPicker{
            selectedBusiness = row
        }else{
            //organizationTextField.text = organizations[row].name
            selectedOrganization = row
        }
        
    }
}

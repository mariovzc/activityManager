import UIKit

class OrganizationVC: UIViewController{
    

    @IBOutlet weak var tableView: UITableView!

    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var organizationService: OrganizationService!
    
    var organizations : [Organization] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTable()
    }

    override func viewDidAppear(_ animated: Bool) {
        refreshTable()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTable() {
        
        organizationService = OrganizationService(context: managedContext)
        organizations = organizationService.getAll()
        
        tableView?.reloadData()
    }
    
}

//TABLE VIEW METHODS
extension OrganizationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = organizations[indexPath.row]
        
        // Instantiate a cell
        let cellIdentifier = "OrganizationCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Adding the right informations
        cell.textLabel?.text = element.name
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

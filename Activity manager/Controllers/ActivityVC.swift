import UIKit

class ActivityVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var activityService: ActivityService!
    
    var activities : [Activity] = []

    
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
        
        activityService = ActivityService(context: managedContext)
        activities = activityService.getAll()
        
        tableView?.reloadData()
    }

}
extension ActivityVC: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = activities[indexPath.row]
        
        // Instantiate a cell
        let cellIdentifier = "ActivityCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        // Adding the right informations
        cell.textLabel?.text = element.desc
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

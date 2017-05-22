//
//  PersonVC.swift
//  Activity manager
//
//  Created by Giancarlo Valencia on 5/22/17.
//  Copyright © 2017 None. All rights reserved.
//

import UIKit
class PersonVC: UIViewController , UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet var personList: UITableView!

    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var personService: PersonService!
    
    var people : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshTable()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddPerson(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "createPatientSegue", sender: nil)
    }
    func refreshTable() {
        
        personService = PersonService(context: managedContext)
        people = personService.getAll()
        DispatchQueue.main.async{
            //self.personList.reloadData()
        }
        //personList.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = people[indexPath.row]
        
        // Instantiate a cell
        let cellIdentifier = "PersonCel"
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

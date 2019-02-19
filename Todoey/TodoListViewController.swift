//
//  ViewController.swift
//  Todoey
//
//  Created by Kate on 1/2/19.
//  Copyright © 2019 Kate Guru. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    @IBOutlet var toDoTableView: UITableView!
    @IBOutlet weak var addButtonPressed: UIBarButtonItem!
    
    var itemArray = ["Wait for Fima", "Give Blood", "Destroy self limiting beliefs"]

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load up the array from user preferences (if we stored something in the file)
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        // deselects the row so it goes back to its default colour
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newToDo = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks on the Add Item button on our UIAlert
            self.itemArray.append(newToDo.text!)
            
            //print(self.itemArray[3].text)

            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
                
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newToDo = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}


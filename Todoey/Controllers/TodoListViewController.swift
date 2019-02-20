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
    
    var itemArray = [ToDoItem]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDoItems.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load up the array from user preferences (if we stored something in the file)
        loadItems()
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        self.saveItems()
        return cell
    }

    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // assign the opposite value to item array flick from true to false or false to true
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newToDo = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newToDoItem = ToDoItem()
            newToDoItem.title = newToDo.text!
            
            //what will happen once the user clicks on the Add Item button on our UIAlert
            self.itemArray.append(newToDoItem)
            self.tableView.reloadData()
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newToDo = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
            
        }
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([ToDoItem].self, from: data)
            } catch {
                print("Error encoding item array, \(error)")
            }
        }
    }
    
}


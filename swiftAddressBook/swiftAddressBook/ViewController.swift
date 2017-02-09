//
//  ViewController.swift
//  swiftAddressBook
//
//  Created by 蒋潇涵 on 2017/2/9.
//  Copyright © 2017年 蒋潇涵. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var personList : [Person] = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPeople()
        
    }
    
    func getPeople() {
        
        DispatchQueue.global().async {
            
            for i in 0..<20 {
                let p = Person()
                p.name = "zhangsan - \(i)"
                p.age = String(i)
                p.phone = "136" + String(format: "%06d", arc4random_uniform(10000000))
                
                self.personList.append(p)
            }
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "people", for: indexPath)
        
        let model = personList[indexPath.row]
        
        cell.textLabel?.text = model.name
        cell.detailTextLabel?.text = model.phone
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "aaa", sender: indexPath)
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        performSegue(withIdentifier: "bbb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! DetailTableViewController
        
        if let indexpath = sender as? IndexPath {
            vc.person = personList[indexpath.row]
            
            vc.save = {
                self.tableView.reloadRows(at: [indexpath], with: .bottom)
            }
        } else {
            
            vc.save = {
                if let person = vc.person {
                    self.personList.insert(person, at: 0)
                    //                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
                    self.tableView.reloadData()
                }
            }
            
        }
        
        
    }
    
    
}


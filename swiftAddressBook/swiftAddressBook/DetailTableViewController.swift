//
//  DetailTableViewController.swift
//  swiftAddressBook
//
//  Created by 蒋潇涵 on 2017/2/9.
//  Copyright © 2017年 蒋潇涵. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    var person: Person?
    
    var save: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let person = person {
            nameTF.text = person.name
            ageTF.text = person.age
            phoneTF.text = person.phone
        }
        
    }


    @IBAction func saveAction(_ sender: Any) {
        
        if person == nil {
            person = Person()
        }
        
        person?.name = nameTF.text
        person?.age = ageTF.text
        person?.phone = phoneTF.text
        
        save?()
        
        _ = navigationController?.popViewController(animated: true)
    }

}

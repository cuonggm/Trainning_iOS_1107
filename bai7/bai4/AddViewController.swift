//
//  AddViewController.swift
//  bai4
//
//  Created by Cuong Giap Minh on 7/17/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var avTextField: UITextField!
    @IBOutlet weak var loviTextField: UITextField!
    
    var avResult: AVResult?
    weak var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func done(_ sender: Any) {
        avResult?.captureDate = datePicker.date
        avResult?.avValue = Float(avTextField.text!)!
        avResult?.loviValue = Int(loviTextField.text!)!
        do {
            try context?.save()
        } catch {
            
        }
        dismiss(animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  bai2
//
//  Created by Cuong Giap Minh on 7/12/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    enum Gender {
        case Male, Female
    }
    
    var gender = Gender.Male {
        willSet {
            if (newValue == .Male) {
                btnMale.setBackgroundImage(UIImage(named: "selected"), for: .normal)
                btnFemale.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
            }
            else if newValue == .Female {
                btnMale.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
                btnFemale.setBackgroundImage(UIImage(named: "selected"), for: .normal)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        btnMale.setBackgroundImage(UIImage(named: "selected") , for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    func isAnyEmpty() -> Bool {
        if (tfFirstName.text!.isEmpty
            || tfLastName.text!.isEmpty
            || tfEmail.text!.isEmpty
            || tfDateOfBirth.text!.isEmpty) {
            return true
        }
        return false
    }
    
    @IBAction func pressedSignUpButton() {
        if !isValidEmail(testStr: tfEmail.text!) {
            showMessage(title: "Email", message: "Wrong email format!")
            return
        }
        if isAnyEmpty() {
            showMessage(title: "Empty", message: "Some field empty!")
            return
        }
        showMessage(title: "Successfully", message: "Signing up is successful!")
    }
    
    @IBAction func chooseMale() {
        gender = .Male
    }
    
    @IBAction func chooseFemale() {
        gender = .Female
    }
}


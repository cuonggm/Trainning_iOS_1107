//
//  ViewController.swift
//  bai4
//
//  Created by Cuong Giap Minh on 7/14/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var moveButton: UIBarButtonItem!

    var items = [AVResult]()
    var canEditing = false {
        didSet {
            if canEditing == false {
                editButton.title = "Edit"
                tableView.setEditing(false, animated: true)
                moveButton.title = "Move"
            } else {
                editButton.title = "Done"
            }
        }
    }
    var tmp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: items[indexPath.row].captureDate)
        cell.dateLabel.text = date
        cell.avLabel.text = "\(items[indexPath.row].avValue)"
        cell.loviLabel.text = "\(items[indexPath.row].loviValue)"
        return cell
    }
    
    func initItems() {
        for i in 0...100 {
            let item = AVResult(captureDate: Date(), avValue: 69.96, loviValue: i+1)
            items.append(item)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEditing
    }
    
    // cho phep di chuyen ma khong cho phep xoa
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if !tableView.isEditing {
            return .delete
        }
        return .none
    }
    
    @IBAction func editButtonPressed() {
        canEditing = !canEditing
    }
    
    @IBAction func moveButtonPressed() {
        if (tableView.isEditing) {
            canEditing = tmp
            moveButton.title = "Move"
            tableView.setEditing(false, animated: true)
        } else {
            tmp = canEditing
            canEditing = true
            moveButton.title = "Done"
            tableView.setEditing(true, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tmp = items[sourceIndexPath.row]
        items[sourceIndexPath.row] = items[destinationIndexPath.row]
        items[destinationIndexPath.row] = tmp
    }
}


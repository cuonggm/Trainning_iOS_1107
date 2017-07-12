//
//  SecondViewController.swift
//  Bai3_Excercise1
//
//  Created by Cuong Giap Minh on 7/12/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class SecondViewController: ViewController {
    
    var grayView: UIView!
    var blueView: UIView!
    var redView: UIView!
    var longTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        initConstraints()
    }
    
    func initViews() {
        grayView = UIView()
        blueView = UIView()
        redView = UIView()
        longTextLabel = UILabel()
        longTextLabel.text = "I have some longer text here that i want to warp onto multiple lines."
        
        grayView.translatesAutoresizingMaskIntoConstraints = false
        blueView.translatesAutoresizingMaskIntoConstraints = false
        redView.translatesAutoresizingMaskIntoConstraints = false
        longTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        grayView.backgroundColor = UIColor.gray
        blueView.backgroundColor = UIColor.blue
        redView.backgroundColor = UIColor.red
        longTextLabel.numberOfLines = 0
        longTextLabel.textAlignment = .center
        
        view.addSubview(grayView)
        view.addSubview(blueView)
        view.addSubview(redView)
        view.addSubview(longTextLabel)
    }
    
    func initConstraints() {
        grayView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        grayView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        grayView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        grayView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        blueView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        blueView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        blueView.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 20).isActive = true
        blueView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        longTextLabel.topAnchor.constraint(equalTo: blueView.topAnchor).isActive = true
        longTextLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        longTextLabel.trailingAnchor.constraint(equalTo: blueView.leadingAnchor).isActive = true
        
        redView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -20).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

//
//  ViewController.swift
//  bai6
//
//  Created by Cuong Giap Minh on 7/15/17.
//  Copyright © 2017 GMC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    @IBOutlet weak var image10: UIImageView!
    @IBOutlet weak var image11: UIImageView!
    @IBOutlet weak var image12: UIImageView!
    
    @IBOutlet weak var timeLable: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var imageViews = [UIImageView]()
    var displayImageNames = [String]()
    
    var statusCards = Array<Bool>(repeating: false, count: 12)
    var hiddenCards = Array<Bool>(repeating: false, count: 12)
    var countTap = 0
    var countTime = 0.0
    let maxTime = 700.0
    var timeStart = 0 {
        didSet {
            timeLable.text = "\(timeStart)"
        }
    }
    
    var timer: Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 15)
        
        imageViews.append(image1)
        imageViews.append(image2)
        imageViews.append(image3)
        imageViews.append(image4)
        imageViews.append(image5)
        imageViews.append(image6)
        imageViews.append(image7)
        imageViews.append(image8)
        imageViews.append(image9)
        imageViews.append(image10)
        imageViews.append(image11)
        imageViews.append(image12)
        
        initGame()
        updateUI()
    }
    
    func getRandomImageNames(count: Int) -> [String] {
        var displayImageNames = [String]()
        for _ in 1...count {
            var name = imageNames[0]
            while displayImageNames.contains(name) {
                let index = Int(arc4random()) % imageNames.count
                name = imageNames[index]
            }
            displayImageNames.append(name)
        }
        return displayImageNames
    }
    
    func initGame() {
        for imageView in imageViews {
            imageView.isUserInteractionEnabled = true
        }
        
        statusCards = Array<Bool>(repeating: false, count: 12)
        hiddenCards = Array<Bool>(repeating: false, count: 12)
        countTap = 0
        
        var tmp = getRandomImageNames(count: 6)
        let count = tmp.count
        for i in 0...(count-1) {
            let name = tmp[i]
            tmp.append(name)
        }
        randomArray(array: &tmp)
        displayImageNames = tmp
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {_ in
            self.countTime += 1
            
            if Int(self.countTime) % 100 == 0 {
                self.timeStart += 1
            }
            
            
            if self.countTime > self.maxTime {
                self.resetCards()
                self.countTime = 0
            }
            self.progressView.setProgress(Float(self.countTime / self.maxTime), animated: false)
        }
    }
    
    func resetCards() {
        closeAllCard()
        countTap = 0
        let numberVisibleImages = countVisibleImage()
        var tmp = getRandomImageNames(count: numberVisibleImages/2)
        let count = tmp.count
        for i in 0...(count-1) {
            let name = tmp[i]
            tmp.append(name)
        }
        randomArray(array: &tmp)
        var index = 0
        for i in 0...(displayImageNames.count-1) {
            if !hiddenCards[i] {
                displayImageNames[i] = tmp[index]
                index += 1
            }
        }
    }
    
    func countVisibleImage() -> Int {
        var count = 0
        for value in hiddenCards {
            if !value {
                count += 1
            }
        }
        
        return count
    }
    
    func loadImage(imageView: UIImageView, imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
    
    func randomArray(array: inout [String]) {
        for _ in 0...(array.count-1)*3 {
            let index1 = Int(arc4random()) % array.count
            let index2 = Int(arc4random()) % array.count
            let tmp = array[index1]
            array[index1] = array[index2]
            array[index2] = tmp
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        for i in 0...(imageViews.count-1) {
            if hiddenCards[i] == true {
                continue
            }
            if statusCards[i] == false {
                loadImage(imageView: imageViews[i], imageName: "question")
            } else {
                loadImage(imageView: imageViews[i], imageName: displayImageNames[i])
            }
        }
    }
    
    func closeAllCard() {
        for i in 0...(statusCards.count-1) {
            statusCards[i] = false
        }
        updateUI()
    }
    
    @IBAction func handleTap(recognizer: UITapGestureRecognizer) {
        if let view = recognizer.view {
            let imageView = view as! UIImageView
            let index = imageViews.index(of: imageView)
            
            if statusCards[index!] == false {
                statusCards[index!] = true
                countTap += 1
                if countTap == 2 {
                    var index1: Int = -1
                    var index2: Int = -1
                    get2openningCard(index1: &index1, index2: &index2)
                    if (displayImageNames[index1] == displayImageNames[index2]) {
                        hideCard(index1)
                        hideCard(index2)
                    }
                }
                if countTap == 3 {
                    closeAllCard()
                    updateUI()
                    countTap = 1
                }
                statusCards[index!] = true
                updateUI()
            }
        }
    }
    
    func hideCard(_ index: Int) {
        imageViews[index].isUserInteractionEnabled = false
        imageViews[index].image = nil
        hiddenCards[index] = true
        checkGameOver()
    }
    
    func checkGameOver() {
        for isHidden in hiddenCards {
            if isHidden == false {
                return
            }
        }
        timer?.invalidate()
        timer = nil
        countTime = 0.0
        
        let alert = UIAlertController(title: "Game Over", message: "Congratulation! You've done :)\nTotal time = \(timeStart)s", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.timeStart = 0
            self.initGame()
            self.updateUI()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func get2openningCard(index1: inout Int, index2: inout Int) {
        for i in 0...(statusCards.count-1) {
            if statusCards[i] == true {
                index1 = i
                for j in (i+1)...(statusCards.count-1) {
                    if statusCards[j] == true {
                        index2 = j
                        break
                    }
                }
                break
            }
        }
    }

}


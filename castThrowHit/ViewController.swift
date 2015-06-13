//
//  ViewController.swift
//  castThrowHit
//
//  Created by Trevor Hall on 6/10/15.
//  Copyright (c) 2015 Trevor Hall. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var startButton: NSLayoutConstraint!
     @IBOutlet weak var grassImage: UIImageView!
       var whichSport = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        instructionLabel.text = "Select a sport from the above menu to continue"

//        if let yourImage = UIImage(named: "green_grass") {
//           self.view.backgroundColor = UIColor(patternImage: UIImage(patternImage: yourImage)
////        }
//        let imageView = UIImageView(image: yourImage)
//        self.view.addSubview(imageView)
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let manager: CMMotionManager = CMMotionManager()
    var distance:Double = 0
    
    @IBAction func startGyro(sender: AnyObject) {
        if whichSport == 0 {
            messageLabel.text = "Please choose a sport"
        } else if manager.gyroAvailable {
            manager.gyroUpdateInterval = 0.1
            manager.startGyroUpdates()
            let queue = NSOperationQueue.mainQueue
            
            manager.startGyroUpdatesToQueue(queue()) {
                (data, error) in
                var x = self.manager.gyroData.rotationRate.x
                if abs(x) > self.distance {
                    self.distance = abs(x)
                }
            }
            var timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("stop"), userInfo: nil,  repeats: false)
            
        }
    }
    func stop() {
        println("Stopped")
        println(Int(self.distance))
        manager.stopGyroUpdates()
        results()
    }
    
    @IBAction func chooseYourSport(sender: UIButton) {
        whichSport = sender.tag
        if whichSport == 1 {
            messageLabel.text = "Lets hit the links"
            instructionLabel.text = "Hit the start button and drive it straight down the fairway!"
        }
        else if whichSport == 2 {
            messageLabel.text = "Let's go fishing!"
            instructionLabel.text = "Hit the start button and cast your line"
        } else if whichSport == 3{
            messageLabel.text = "Grab your racket and serve it up!"
            instructionLabel.text = "Hit start and serve the ball!"
        } else if whichSport == 4{
            messageLabel.text = "Lets see what you've got!"
            instructionLabel.text = "Take the mound and strike 'em out"
        } else if whichSport == 5{
            messageLabel.text = "Step up to the plate!"
            instructionLabel.text = "Hit start and knock it out of the park!"
        }
    }
    
    func results() {
        var results = abs(Int(self.distance))
        println(distance)
        if whichSport == 1{
            messageLabel.text = "You drove \(results * 12) yards!"
        } else if whichSport == 2 {
            messageLabel.text = "You cast \(results*2) feet"
        } else if whichSport == 3 {
            messageLabel.text = "You served \(results * 3) MPH!"
        } else if whichSport == 4 {
            messageLabel.text = "You threw the ball \(results*3) MPH!"
        } else if whichSport == 5{
            if results < 2 {
                messageLabel.text = "Oops, you forgot to swing."
            }
            else if results <= 6 {
                messageLabel.text = "Bunt! You reach first base!"
            } else if results <= 8 {
                messageLabel.text = "Picked off at first..."
            } else if results <= 12 {
                messageLabel.text = "Base hit!"
            } else if results <= 16 {
                messageLabel.text = "Picked off at 2nd.  Should have stayed at 1st..."
            } else if results <= 19 {
                messageLabel.text = "Go ahead and take third!"
            } else if results <= 24 {
                messageLabel.text = "Picked off at third"
            } else if results <= 27 {
                messageLabel.text = "Home Run!!!"
            } else{
                messageLabel.text = "Grand Slam!!!!"
            }
        }
         instructionLabel.text = "Choose another sport from the menu to continue"
        self.distance = 0
        whichSport = 0
    }
   
    

    


}


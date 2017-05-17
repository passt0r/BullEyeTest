//
//  ViewController.swift
//  BullEye
//
//  Created by Dmytro Pasinchuk on 12.05.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlited = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let leftTrackImage = UIImage(named: "SliderTrackLeft")
        let leftTrackResizable = leftTrackImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(leftTrackResizable, for: .normal)
        let rightTrackImage = UIImage(named: "SliderTrackRight")
        let rightTrackResizable = rightTrackImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(rightTrackResizable, for: .normal)
        
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTarget() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    func startNewGame() {
        score = 0
        round = 0
        newRound(slider)
    }
    func newRound(_ sender: Any) {
        targetValue = 1+Int(arc4random_uniform(100))
        currentValue = 50
        round += 1
        slider.value = Float(currentValue)
        updateTarget()
    }

    @IBAction func showAlert() {
        let difference = abs(currentValue-targetValue)
        var points = 100-difference
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You was close"
            points += 50
        } else if difference < 10 {
            title = "It was a good try"
        } else {
            title = "You can better"
        }
        score += points
        //let message = "The value of a slider is: \(currentValue)" + "\nTarget value is: \(targetValue)" + "\nDifference is: \(difference)"
        let alertController = UIAlertController(title: title, message: "Your score is: \(points)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok, got it", style: .default, handler: {action in self.newRound(action)
            //self.updateTarget()
        })
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
        
    }

    @IBAction func sliderMoved(_ sender: UISlider) {
        //print("New slider value is: \(sender.value)")
        currentValue = lroundf(sender.value)
    }
    
    @IBAction func startOver(_ sender: Any) {
        startNewGame()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
        
    }
}


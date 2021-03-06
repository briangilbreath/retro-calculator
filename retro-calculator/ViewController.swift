//
//  ViewController.swift
//  retro-calculator
//
//  Created by Brian on 2/2/16.
//  Copyright © 2016 Brian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation:String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty;
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        
    }
    

    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        processOperation(Operation.Clear)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
         processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
         processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
         processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
         processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if op == Operation.Clear{
            
            print("clear");
                
                runningNumber = ""
                leftValString = ""
                rightValString = ""
                outputLbl.text = "0"
                result = ""
                
                currentOperation = Operation.Empty
            
        }else{
            
            
            if currentOperation != Operation.Empty{
                //run math
                
                print("math")
                
                //A user selected an operator, but then selected another operator without selecting a number
                if runningNumber != ""{
                    
                    rightValString = runningNumber
                    runningNumber = ""
                    
                    if currentOperation == Operation.Multiply{
                        result = "\(Double(leftValString)! * Double(rightValString)!)"
                    }else if currentOperation == Operation.Divide{
                        result = "\(Double(leftValString)! / Double(rightValString)!)"
                    }else if currentOperation == Operation.Subtract{
                        result = "\(Double(leftValString)! - Double(rightValString)!)"
                    }else if currentOperation == Operation.Add{
                        result = "\(Double(leftValString)! + Double(rightValString)!)"
                    }
                    
                    leftValString = result
                    outputLbl.text = result
                    
                }
                
                
                currentOperation = op
                
            } else {
                // this is the first time an operator has been pressed
                
                print("first press")
                
                leftValString = runningNumber
                runningNumber = ""
                
                currentOperation = op
                
            }
        }
        
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }


}


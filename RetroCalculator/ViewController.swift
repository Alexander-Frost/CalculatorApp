//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Alex on 4/1/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNum: String = ""
    var leftVarStr = ""
    var rightVarStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    
    @IBAction func numberPressed (btn: UIButton!) {
        btnSound.play()
        
        runningNum += "\(btn.tag)"
        outputLbl.text = runningNum
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
    
    @IBAction func onClearPressed(sender: AnyObject) {
        outputLbl.text = "0"
        processOperation(Operation.Empty)
    }
    
    func processOperation (op: Operation){
        playSound()
        
        //user selected one operator after an operator
        if currentOperation != Operation.Empty  {
            //run the math
            if runningNum != "" {
                
                rightVarStr = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                }
                
                leftVarStr = result
                outputLbl.text = result
                }
                currentOperation = op
        }
            
        else {
            //first time operator has been pressed
            leftVarStr = runningNum
            runningNum = ""
            currentOperation = op
        }
    }
    
    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        else {btnSound.play() }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


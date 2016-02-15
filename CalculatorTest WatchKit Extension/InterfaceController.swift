//
//  InterfaceController.swift
//  CalculatorTest WatchKit Extension
//
//  Created by Daniel Puga on 3/1/16.
//  Copyright © 2016 LJPDB. All rights reserved.
//

import WatchKit
import Foundation

enum modes {
    case NOT_SET
    case ADDITION
    case SUBSTRACTION
}

class InterfaceController: WKInterfaceController {

    var resultLabelValue : String = "0"
    var savedNum : Int32 = 0
    var lastButtonMode : Bool = false
    var currentMode : modes = .NOT_SET
    @IBOutlet var resultLabel: WKInterfaceLabel!
    
    @IBAction func equalButtonPressed() {
        guard let num : Int32 = Int32(resultLabelValue) else{
            return
        }
        if currentMode == .NOT_SET || lastButtonMode{
            return
        }
        if currentMode == .SUBSTRACTION{
            savedNum -= num
        }
        else if currentMode == .ADDITION{
            savedNum += num
        }
        currentMode = .NOT_SET
        resultLabelValue = "\(savedNum)"
        convertToInt(0, equalsPressed: true)
        lastButtonMode = true
    }
    
    @IBAction func clearButtonPressed() {
        currentMode = .NOT_SET
        savedNum = 0
        resultLabel.setText("0")
        lastButtonMode = false
        resultLabelValue = "0"
    }
    
    func changeMode(modeToSet: modes){
        if savedNum == 0 {
            return
        }
        currentMode = modeToSet
        lastButtonMode = true
    }
    
    @IBAction func minusButtonPressed() {
        changeMode(.SUBSTRACTION)
    }
    
    @IBAction func plusButtonPressed() {
        changeMode(.ADDITION)
    }
    
    @IBAction func buttonCeroPressed() {
        convertToInt(0, equalsPressed: false)
    }
    @IBAction func buttonOnePressed() {
        convertToInt(1, equalsPressed: false)
    }
    @IBAction func buttonTwoPressed() {
        convertToInt(2, equalsPressed: false)
    }
    @IBAction func buttonThreePressed() {
        convertToInt(3, equalsPressed: false)
    }
    @IBAction func buttonFourPressed() {
        convertToInt(4, equalsPressed: false)
    }
    @IBAction func buttonFivePressed() {
        convertToInt(5, equalsPressed: false)
    }
    @IBAction func buttonSixPressed() {
        convertToInt(6, equalsPressed: false)
    }
    @IBAction func buttonSevenPressed() {
        convertToInt(7, equalsPressed: false)
    }
    @IBAction func buttonEightPressed() {
        convertToInt(8, equalsPressed: false)
    }
    @IBAction func buttonNinePressed() {
        convertToInt(9, equalsPressed: false)
    }
    
    func convertToInt(numberpressed: Int32, equalsPressed: Bool){
        if equalsPressed{
            resultLabel.setText("\(formatNumber(savedNum))")
            return
        }
        if lastButtonMode {
            lastButtonMode = false
            resultLabelValue = "0"
        }
        resultLabelValue = resultLabelValue.stringByAppendingString("\(numberpressed)")
        guard let labelInt : Int32 = Int32(resultLabelValue)else{
            resultLabel.setText("number is too large")
            return
        }
        savedNum = (currentMode == .NOT_SET) ? labelInt : savedNum
        resultLabel.setText("\(formatNumber(labelInt))")
        //if()
    }
    
    func formatNumber(numberToFormat: Int32) -> String{
        let formatter : NSNumberFormatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        let nsInt : NSNumber = NSNumber(int: numberToFormat)
        let strFinalInt = formatter.stringFromNumber(nsInt)
        return strFinalInt!
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

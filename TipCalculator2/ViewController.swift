//
//  ViewController.swift
//  TipCalculator2
//
//  Created by Yrua Riley on 5/11/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
  
  
  
  var billAmountDisplay: Int = 0
  var billAmount: Double = 0
  var alertController: UIAlertController?
  
  @IBOutlet weak var tipPickerView: UIPickerView!
  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    billAmountTextField.delegate = self
    billAmountTextField.placeholder = updateAmount()
    tipPickerView.delegate = self
    
    initDisplay()
  }
  
  func initDisplay() {
    //Start value for tip and total amount formated to local currency
    tipAmountLabel.text = formatCurrency(0.00)
    totalLabel.text = formatCurrency(0.00)
  }
  
  //Format bill amount as user enters it
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let digit = Int(string) {
      billAmountDisplay = billAmountDisplay * 10 + digit
      billAmountTextField.text = updateAmount()
    }
    if string == "" {
      billAmountDisplay = billAmountDisplay/10
      billAmountTextField.text = billAmountDisplay == 0 ? "" : updateAmount()
    }
    return false
  }

  func updateAmount() -> String? {
    let amount = Double(billAmountDisplay/100) + Double(billAmountDisplay%100)/100
    billAmount = amount
    return formatCurrency(amount)
  }

  
  let tipAmounts = ["10%","15%","20%"]
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return tipAmounts[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    tipAmounts.count
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if (row == 0) {
      calculateTip(0.10)
    } else if (row == 1) {
      calculateTip(0.15)
    } else {
        calculateTip(0.20)
    }
  }
  
  @IBAction func calculateTip(_ tipPercentage: Double) {
    //Get Total tip
    let tip = billAmount * tipPercentage
    let total = billAmount + tip
  
    //Update Tip Amount Label
    tipAmountLabel.text = formatCurrency(tip)
    
    //Update total amount
    totalLabel.text = formatCurrency(total)
  }
}


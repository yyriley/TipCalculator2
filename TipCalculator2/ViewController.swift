//
//  ViewController.swift
//  TipCalculator2
//
//  Created by Yrua Riley on 5/11/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  var billAmountDisplay: Int = 0
  var billAmount: Double = 0
  var alertController: UIAlertController?
  
  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    billAmountTextField.delegate = self
    billAmountTextField.placeholder = updateAmount()

  }
  
  
  //Format bill amount as entered by user
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
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currency
    let amount = Double(billAmountDisplay/100) + Double(billAmountDisplay%100)/100
    billAmount = amount
    return formatter.string(from: NSNumber(value:amount))
  }

  @IBAction func calculateTip(_ sender: Any) {
    //Get Total tip
    let tipPercentages = [0.15, 0.18, 0.2]
    let tip = billAmount * tipPercentages[tipControl.selectedSegmentIndex]
    let total = billAmount + tip
  
    
    //Update Tip Amount Label
    tipAmountLabel.text = String(format: "%.2f", tip)
    
    //Update total amount
    totalLabel.text = String(format: "%.2f", total)
    
  }
}


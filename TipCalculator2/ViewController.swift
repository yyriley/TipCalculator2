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
  
  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    billAmountTextField.delegate = self
    billAmountTextField.placeholder = updateAmount()

  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if let digit = Int(string) {
      billAmountDisplay = billAmountDisplay * 10 + digit
      
      if billAmountDisplay > 1_000_000_000_00 {
        let alert = UIAlertController(title: "Please enter amount less than 1 billion", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
      
        present(alert, animated: true, completion: nil)
        billAmountTextField.text = ""
      } else {
        billAmountTextField.text = updateAmount()
      }
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
    
    let formatter = NumberFormatter()
    formatter.numberStyle = NumberFormatter.Style.currency
    formatter.string(from: NSNumber(value:tip))
    
    //Update Tip Amount Label
    tipAmountLabel.text = String(format: "%.2f", formatter)
    
    //Update total amount
    totalLabel.text = String(format: "%.2f", total)
    
  }
  
}


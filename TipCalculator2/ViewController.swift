//
//  ViewController.swift
//  TipCalculator2
//
//  Created by Yrua Riley on 5/11/21.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var tipControl: UISegmentedControl!
  @IBOutlet weak var tipAmountLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  

  @IBAction func calculateTip(_ sender: Any) {
    //Get bill amount
    let bill = Double(billAmountTextField.text!) ?? 0
    
    //Get Total tip
    let tipPercentages = [0.15, 0.18, 0.2]
    let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
    let total = bill + tip
    
    //Update Tip Amount Label
    tipAmountLabel.text = String(format: "$%.2f", tip)
    
    //Update total amount
    totalLabel.text = String(format: "$%.2f", total)
    
  }
  
  
  func convertDoubleToCurrency(amount: Double) -> String{
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = .currency
      numberFormatter.locale = Locale.current
      return numberFormatter.string(from: NSNumber(value: amount))!
  }
  func convertCurrencyToDouble(input: String) -> Double? {
       let numberFormatter = NumberFormatter()
       numberFormatter.numberStyle = .currency
       numberFormatter.locale = Locale.current
       return numberFormatter.number(from: input)?.doubleValue
  }
  
}


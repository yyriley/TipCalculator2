//
//  CurrencyFormatter.swift
//  TipCalculator2
//
//  Created by Yrua Riley on 5/13/21.
//

import Foundation
func formatCurrency(_ currencyValue: Double) -> String? {
  let formatter = NumberFormatter()
  formatter.numberStyle = NumberFormatter.Style.currency
  return formatter.string(from: NSNumber(value:currencyValue))
}

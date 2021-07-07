//
//  CoinModel.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 07/07/2021.
//

import Foundation

struct CoinModel {
  let coinRate: Double
  
  var rateString: String {
    return String(format: "%.2f", coinRate)
  }
}


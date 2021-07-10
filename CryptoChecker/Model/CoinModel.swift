//
//  CoinModel.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 07/07/2021.
//

import UIKit

let logo = [#imageLiteral(resourceName: "BTC.png"), #imageLiteral(resourceName: "ETH.png"), #imageLiteral(resourceName: "DOT.png"), #imageLiteral(resourceName: "ADA.png"), #imageLiteral(resourceName: "DOGE.png"), #imageLiteral(resourceName: "MAID.png")]

struct CoinModel {
  let coin: String
  
  var coinImage: UIImage {
    switch coin {
    case "BTC":
      return logo[0]
    case "ETH":
      return logo[1]
    case "DOT":
      return logo[2]
    case "ADA":
      return logo[3]
    case "DOGE":
      return logo[4]
    case "MAID":
      return logo[5]
    default:
      return logo[0]
    }
  }
}


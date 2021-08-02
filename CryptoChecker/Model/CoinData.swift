//
//  CoinData.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 07/07/2021.
//

import Foundation

struct CoinData: Codable {
  let asset_id_base: String
  let rate: Double
  let src_side_base: [USD]
}

struct USD: Codable {
  let rate: Double
}

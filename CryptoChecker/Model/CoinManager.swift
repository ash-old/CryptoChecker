//
//  CoinManager.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 06/07/2021.
//

import Foundation

protocol CoinManagerDelegate {
  func didUpdateCoin(_ coinManager: CoinManager)
  func didFailWithError(error: Error)

}

struct CoinManager {
  
  let url = "https://rest.coinapi.io/v1/exchangerate/"
  let apiKey = "3622CA84-CE70-47F0-AE8F-DE9419C07B17"
  
  let cryptoArray = ["BTC", "ETH", "DOT", "ADA", "DOGE", "MAID"]
  
  var delegate: CoinManagerDelegate?
  
  func getCryptoCoin(for coin: String) {
    let urlString = "\(url)\(coin)/USD?apikey=\(apiKey)"
    //print(urlString)
    performRequest(with: urlString)
  }
  
  func performRequest(with urlString: String) {
    //1. create a URL
    if let url = URL(string: urlString) {
      
      //2. create a URLSession
      let session = URLSession(configuration: .default)
      
      //3. give the session a task
      let task = session.dataTask(with: url) { (data, response, error) in
        if error != nil {
          delegate?.didFailWithError(error: error!)
          print("Error", error!)
          return
        }
        
        if let safeData = data {
//          print("safeData", String(data: safeData, encoding: String.Encoding.ascii)!)
          if let coinRate = parseJSON(safeData) {
//            delegate?.didUpdateCoin(coinManager: coinRate)
          }
        }
      }
      
      //4. start the task
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) -> Double? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CoinData.self, from: data)
      let coinPrice = decodedData.rate
      print(coinPrice)
      return coinPrice
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
}

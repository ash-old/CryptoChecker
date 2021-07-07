//
//  CoinManager.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 06/07/2021.
//

import Foundation

struct CoinManager {
  
  let url = "https://rest.coinapi.io/v1/exchangerate/"
  let apiKey = "3622CA84-CE70-47F0-AE8F-DE9419C07B17"
  
  let cryptoArray = ["BTC", "ETH", "DOT", "ADA", "DOGE", "MAID"]
  
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
          //delegate?.didFailWithError(error: error!)
          print("Error", error!)
          return
        }
        
        if let safeData = data {
          print("safeData", String(data: safeData, encoding: String.Encoding.ascii)!)
//          if let weather = parseJSON(safeData) {
//            delegate?.didUpdateWeather(self, weather: weather)
//          }
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
      let lastPrice = decodedData.rate
      
      return lastPrice
      
    } catch {
      //delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
}

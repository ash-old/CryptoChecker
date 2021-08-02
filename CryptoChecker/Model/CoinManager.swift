//
//  CoinManager.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 06/07/2021.
//

import Foundation

protocol CoinManagerDelegate {
//  func didUpdateCoin(coin: String, rate: String)
  func didUpdateCoin(coinData: CoinModel)
  func didFailWithError(error: Error)
  
}

struct CoinManager {
  
  let url = "https://rest.coinapi.io/v1/exchangerate/"
  let apiKey = "3622CA84-CE70-47F0-AE8F-DE9419C07B17"
  
  let cryptoArray = ["BTC", "ETH", "DOT", "ADA", "DOGE", "MAID"]
  
  var delegate: CoinManagerDelegate?
  
  func getCryptoCoin(for coin: String) {
    
    let group = DispatchGroup()
    
//    let urlString1 = "\(url)\(coin)/USD?apikey=\(apiKey)"
    let urlString2 = "\(url)\(coin)/GBP?apikey=\(apiKey)"
    print("gbp", urlString2)
  
    //1. create a URL
     let urls = [
//        URL(string: urlString1),
        URL(string: urlString2),
        ]
      
      //2. create a URLSession
      let session = URLSession(configuration: .default)
      
      //3. give the session a task
      for url in urls {
        group.enter()
      
      let task = session.dataTask(with: url!) { (data, response, error) in
        if error != nil {
          delegate?.didFailWithError(error: error!)
          print("Error", error!)
          group.leave()
          group.notify(queue: DispatchQueue.main, execute: {
                 print("All Done");
               })
          return
        
        }
        
        if let safeData = data {
          //          print("safeData", String(data: safeData, encoding: String.Encoding.ascii)!)
          if let coinRate = parseJSON(safeData) {
//            print("data", coinRate)
//            let StringRate = String(format: "%.2f", coinRate)
            delegate?.didUpdateCoin(coinData: coinRate)
            
          }
        }
      }
      
      //4. start the task
      task.resume()
      
    }
  }
  
  func parseJSON(_ data: Data) -> CoinModel? {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(CoinData.self, from: data)
      let name = decodedData.asset_id_base
      let gbpPrice = decodedData.rate
      let usdPrice = decodedData.src_side_base[2].rate
//      print("usd", usdPrice)
      let coinModel = CoinModel(coin: name, gbpRate: gbpPrice, usdRate: usdPrice)
      return coinModel
      
    } catch {
      delegate?.didFailWithError(error: error)
      return nil
    }
  }
  
}

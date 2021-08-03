//
//  ViewController.swift
//  CryptoChecker
//
//  Created by Ash Oldham on 05/07/2021.
//

import UIKit

class ViewController: UIViewController {
  
  var coinManager = CoinManager()

  @IBOutlet weak var cryptoPicker: UIPickerView!
  @IBOutlet weak var currencyLabelUSD: UILabel!
  @IBOutlet weak var coinImage: UIImageView!
  @IBOutlet weak var currencyLabelGBP: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    cryptoPicker.dataSource = self
    cryptoPicker.delegate = self
    coinManager.delegate = self
  }

}

//MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManager.cryptoArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return NSAttributedString(string: coinManager.cryptoArray[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemPink])
  }
}

//MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return coinManager.cryptoArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //print(coinManager.cryptoArray[row])
    let selectedCrypto = coinManager.cryptoArray[row]
    coinManager.getCryptoCoin(for: selectedCrypto)
  }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
  
  func didUpdateCoin(coinData: CoinModel) {
//    let coinModel = CoinModel(coin: coin)
    
    DispatchQueue.main.async {
      self.currencyLabelUSD.text = "$ \(coinData.usdString)"
      self.currencyLabelGBP.text = "£ \(coinData.gbpString)"
      self.coinImage.image = coinData.coinImage
    }
  }
  
  func didFailWithError(error: Error) {
    print(error)
  }
  
}


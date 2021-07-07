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
  
  func didUpdateCoin(_ coinManager: CoinManager, rate: CoinModel) {
    DispatchQueue.main.async {
      self.currencyLabelUSD.text = rate.rateString
    }
  }
  
  func didFailWithError(error: Error) {
    print(error)
  }
  
}


//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCurrency(_ currencyLabel : String, _ currencyRate : String)
    func didFailWithError(error : Error)
}
struct CoinManager {
    
    let baseURL = "https://api.coingate.com/v2/rates/merchant/BTC/"
    
    var delegate : CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency : String){
        let urlString = "\(baseURL)\(currency)"
        performRequest(for: urlString, for : currency)
    }
    func performRequest(for urlString: String, for currencyLabel : String){
        if let url = URL(string : urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data,response,error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let rate = String(data: safeData, encoding: .utf8){
                        self.delegate?.didUpdateCurrency(currencyLabel,rate)
                    }
                        
                }
        }
            task.resume()
    }
    
}
    
    

}

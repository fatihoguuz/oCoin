//
//  Webservice.swift
//  oCoin
//
//  Created by Fatih Oğuz on 29.07.2024.
//

import Foundation

enum cryptoError: Error {
    case serverError
    case parsingError
}
class Webservice {
    
    func downloadCurrencies(url: URL , completion: @escaping (Result<[Crypto], cryptoError>) -> () ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.serverError))
            }else if let data = data  {
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                if let cryptoList = cryptoList {
                    completion(.success(cryptoList))
                }else {
                    completion(.failure(.parsingError))
                }
            }
        }.resume()
    }
    
}

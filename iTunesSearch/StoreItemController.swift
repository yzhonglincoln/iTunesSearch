//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Soft Dev on 4/20/20.
//  Copyright © 2020 Caleb Hicks. All rights reserved.
//

import Foundation

class StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping([StoreItem]?) -> Void) {
        let baseURL = URL(string: "https://itunes.apple.com/search?")!
        let query: [String: String] = [:]
        
        let url = baseURL.withQueries(query)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
                if let data = data,
                    let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
                    completion(storeItems.results)
                    } else {
                        print("Either no data was returned, or data was not properly decoded.")
                        completion(nil)
                }
        }
        task.resume()
    }
}

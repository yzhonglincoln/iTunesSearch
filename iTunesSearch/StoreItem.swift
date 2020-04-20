//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Soft Dev on 4/20/20.
//  Copyright © 2020 Caleb Hicks. All rights reserved.
//

import Foundation

struct StoreItem: Codable {
    var wrapperType: String?
    var kind: String?
    var artistName: String
    var collectionName: String?
    var collectionViewUrl: URL?
    var collectionPrice: Double?
    var trackName: String?
    var trackViewUrl: URL?
    var trackPrice: Double?
    var formattedPrice: Double?
    var price: Double?
    var artworkUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case wrapperType
        case kind
        case artistName
        case collectionName
        case collectionViewUrl
        case collectionPrice
        case trackName
        case trackViewUrl
        case trackPrice
        case formattedPrice
        case price
        case artworkUrl = "artworkUrl30"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.wrapperType = try? valueContainer.decode(String.self, forKey: CodingKeys.wrapperType)
        self.kind = try? valueContainer.decode(String.self, forKey: CodingKeys.kind)
        self.artistName = try valueContainer.decode(String.self, forKey: CodingKeys.artistName)
        self.collectionName = try? valueContainer.decode(String.self, forKey: CodingKeys.collectionName)
        self.collectionViewUrl = try? valueContainer.decode(URL.self, forKey: CodingKeys.collectionViewUrl)
        self.collectionPrice = try? valueContainer.decode(Double.self, forKey: CodingKeys.collectionPrice)
        self.trackName = try? valueContainer.decode(String.self, forKey: CodingKeys.trackName)
        self.trackViewUrl = try? valueContainer.decode(URL.self, forKey: CodingKeys.trackViewUrl)
        self.trackPrice = try? valueContainer.decode(Double.self, forKey: CodingKeys.trackPrice)
        self.formattedPrice = try? valueContainer.decode(Double.self, forKey: CodingKeys.formattedPrice)
        self.price = try? valueContainer.decode(Double.self, forKey: CodingKeys.price)
        self.artworkUrl = try valueContainer.decode(URL.self, forKey: CodingKeys.artworkUrl)
    }
}

struct StoreItems: Codable {
    let results: [StoreItem]
}

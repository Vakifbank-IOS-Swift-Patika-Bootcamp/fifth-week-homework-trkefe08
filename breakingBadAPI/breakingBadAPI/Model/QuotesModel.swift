//
//  QuotesModel.swift
//  breakingBadAPI
//
//  Created by Tarik Efe on 27.11.2022.
//

import Foundation

struct QuotesModel: Codable {
    let quoteID: Int?
    let quote, author, series: String?

    enum CodingKeys: String, CodingKey {
        case quoteID = "quote_id"
        case quote, author, series
    }
}

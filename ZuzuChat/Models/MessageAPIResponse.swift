//
//  MessageAPIResponse.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Foundation

struct MessageAPIResponse: Decodable {
  let status: String
  let totalResults: Int
  let results: [MessageResponse]
}

struct MessageResponse: Decodable {
  let articleId: String
  let title: String
  let link: String
  let keywords: [String]?
  let creator: [String]?
  let description: String?
  let content: String?
  let pubDate: String
  let imageUrl: String?
  let videoUrl: String?
  let sourceName: String
}

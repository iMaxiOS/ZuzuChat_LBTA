//
//  NewsResponse.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Foundation

struct NewsAPIResponse: Codable {
  let status: String
  let totalResults: Int
  let results: [NewsResponse]
}

struct NewsResponse: Codable {
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
  let sourceId: String
  let sourceName: String
  let sourcePriority: Int
  let sourceUrl: String
  let sourceIcon: String
  let language: String
  let country: [String]
  let category: [String]
  let sentiment: String
  let sentimentStats: String?
}

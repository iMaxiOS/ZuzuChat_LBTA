//
//  NewsResponse.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Foundation

struct NewsAPIResponse: Codable, Hashable {
  let status: String
  let totalResults: Int
  let results: [NewsResponse]
}

struct NewsResponse: Codable, Hashable {
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
  
  
  init() {
    self.articleId = ""
    self.title = ""
    self.link = ""
    self.keywords = []
    self.creator = []
    self.description = nil
    self.content = nil
    self.pubDate = ""
    self.imageUrl = nil
    self.videoUrl = nil
    self.sourceId = ""
    self.sourceName = ""
    self.sourcePriority = -1
    self.sourceUrl = ""
    self.sourceIcon = ""
    self.language = ""
    self.country = []
    self.category = []
    self.sentiment = ""
    self.sentimentStats = nil
  }
}

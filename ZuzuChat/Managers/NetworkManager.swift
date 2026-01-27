//
//  NetworkManager.swift
//  ZuzuChat
//
//  Created by Maxim Hranchenko on 15.04.2025.
//

import Foundation

final class NetworkManager {
  static let shared = NetworkManager()
  
  private init() {}
  
  private let baseURL = "https://newsdata.io/api/1/latest"
  private let apiKey = "pub_b4968addff094216b123fb0986f07cbc"
  
  func fetchPoliticsNews(for country: String = "us", for category: String = "politics") async throws -> [NewsResponse] {
    var components = URLComponents(string: baseURL)!
    components.queryItems = [
      URLQueryItem(name: "apikey", value: apiKey),
      URLQueryItem(name: "category", value: category),
      URLQueryItem(name: "country", value: country)
    ]
    
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
      throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let result = try decoder.decode(NewsAPIResponse.self, from: data)
    return result.results
  }
  
  func fetchMessages(for country: String = "us") async throws -> [MessageResponse] {
    var components = URLComponents(string: baseURL)!
    components.queryItems = [
      URLQueryItem(name: "apikey", value: apiKey),
      URLQueryItem(name: "country", value: country),
      URLQueryItem(name: "prioritydomain", value: "top")
    ]
    
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
      throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let result = try decoder.decode(MessageAPIResponse.self, from: data)
    return result.results
  }
  
  func searchNews(query: String) async throws -> [NewsResponse] {
    guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
      throw URLError(.badURL)
    }
    
    var components = URLComponents(string: baseURL)!
    components.queryItems = [
      URLQueryItem(name: "apikey", value: apiKey),
      URLQueryItem(name: "q", value: query)
    ]
    
    guard let url = components.url else {
      throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200..<300).contains(httpResponse.statusCode) else {
      throw URLError(.badServerResponse)
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    
    let result = try decoder.decode(NewsAPIResponse.self, from: data)
    return result.results
  }
}

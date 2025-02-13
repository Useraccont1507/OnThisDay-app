//
//  NetworkService.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case dataIsNil
  case error
  case decodingError
}

protocol NetworkServiceProtocol {
  func fetchEvents(eventType: EventType, day: Int, month: Int ,completion: @escaping (Result<Events, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  func fetchEvents(eventType: EventType, day: Int, month: Int ,completion: @escaping (Result<Events, NetworkError>) -> Void) {
    guard let url = URL(string: "https://en.wikipedia.org/api/rest_v1/feed/onthisday/\(eventType.rawValue)/\(month)/\(day)") else {
      return completion(.failure(.badUrl))
    }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      guard error != nil else { return completion(.failure(.error)) }
      guard let data = data else { return completion(.failure(.dataIsNil)) }
      
      do {
        let result = try JSONDecoder().decode(Events.self, from: data)
        completion(.success(result))
      } catch {
        completion(.failure(.decodingError))
      }
    }.resume()
  }
}

//
//  NetworkService.swift
//  OnThisDay
//
//  Created by Illia Verezei on 13.02.2025.
//

import Foundation

enum NetworkError: Error {
  case badUrl
  case error
  case dataIsNil
  case decodingError
}

protocol NetworkServiceProtocol {
  func fetchEvents(eventType: EventType, day: Int, month: Int ,completion: @escaping (Result<EventsGeocoding, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
  func fetchEvents(eventType: EventType, day: Int, month: Int ,completion: @escaping (Result<EventsGeocoding, NetworkError>) -> Void) {
    guard let url = URL(string: "https://byabbe.se/on-this-day/\(month)/\(day)/\(eventType).json") else {
      return completion(.failure(.badUrl))
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "accept")
    
    URLSession.shared.dataTask(with: request) { data, _, error in
      guard error == nil else { return completion(.failure(.error)) }
      guard let data = data else { return completion(.failure(.dataIsNil)) }
      
      do {
        let result = try JSONDecoder().decode(EventsGeocoding.self, from: data)
        completion(.success(result))
      } catch {
        print(error)
        completion(.failure(.decodingError))
      }
    }.resume()
  }
}

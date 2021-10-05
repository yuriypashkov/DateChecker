//
//  NetworkService.swift
//  DateChecker
//
//  Created by Yuriy Pashkov on 9/16/21.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    private lazy var urlSession: URLSession = {
        return URLSession.init(configuration: .default)
    }()
    
    func requestBeerData(completion: @escaping (Result<[BeerData], Error>) -> Void) {
        guard let url = URL(string: NetworkConfiguration.apiUrl + "/beers") else { return }
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 400 else {
                completion(.failure(NetworkError.failedResponse))
                return
            }
            
            do {
                let beerResponse = try JSONDecoder().decode([BeerData].self, from: data)
                completion(.success(beerResponse))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        dataTask.resume()
        
    }
    
    func requestBreweryData(onResult: @escaping (Result<[BreweryData], Error>) -> Void) {
        let url = URL(string: NetworkConfiguration.apiUrl + "/breweries")!
        let urlRequest = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                onResult(.failure(NetworkError.noData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 400 else {
                onResult(.failure(NetworkError.failedResponse))
                return
            }
            
            do {
                let beerInfoResponse = try JSONDecoder().decode([BreweryData].self, from: data)
                onResult(.success(beerInfoResponse))
            }
            catch {
                onResult(.failure(NetworkError.decodingError))
            }
        }
        
        dataTask.resume()
    }
    
}

enum NetworkError: Error {
    case noData
    case failedResponse
    case decodingError
}

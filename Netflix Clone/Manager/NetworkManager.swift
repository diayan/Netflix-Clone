//
//  API.swift
//  Netflix Clone
//
//  Created by diayan siat on 26/02/2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getTrendingMovies(completed: @escaping (Result<[Movies], NFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/trending/movie/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse<Movies>.self, from: data)
                completed(.success(result.results ?? []))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func getTrendingTVs(completed: @escaping (Result<[Movies], NFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/trending/tv/day?api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse<Movies>.self, from: data)
                completed(.success(result.results ?? []))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
    func getUpcomingMovies(completed: @escaping (Result<[Movies], NFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse<Movies>.self, from: data)
                completed(.success(result.results ?? []))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getPopular(completed: @escaping (Result<[Movies], NFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse<Movies>.self, from: data)
                completed(.success(result.results ?? []))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getTopRated(completed: @escaping (Result<[Movies], NFError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse<Movies>.self, from: data)
                completed(.success(result.results ?? []))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    
}

//
//  KakaoService.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import Foundation

final class KakaoService {
    
    // MARK: - Properties
    
    static let shared = KakaoService()
    
    private let baseURL = "https://dapi.kakao.com/v2/search/image"
    
    // MARK: - Life Cycle
    
    private init() { }
    
    // MARK: - Helpers
    
    func getImages(keyward: String, sort: Sort = .accuracy, page: Int = 1, completion: @escaping (Result<SearchResult, NetworkingError>) -> () ) {
        
        var components = URLComponents(string: baseURL)
        let query = URLQueryItem(name: "query", value: keyward)
        components?.queryItems = [query]
        let sort = URLQueryItem(name: "sort", value: sort.rawValue)
        components?.queryItems?.append(sort)
        let page = URLQueryItem(name: "page", value: String(page))
        components?.queryItems?.append(page)
        let size = URLQueryItem(name: "size", value: "30")
        components?.queryItems?.append(size)
        
        if let url = components?.url {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("KakaoAK 26a064bb00e0f331a0f853ceea59fd4c", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { (data, res, error) in
                debugPrint(res)
                guard error == nil else {
                    completion(.failure(.requestError))
                    return
                }
                
                guard let statusCode = (res as? HTTPURLResponse)?.statusCode else {
                    completion(.failure(.responseError))
                    return
                }

                switch statusCode {
                
                case 200...299:
                    
                    if let data = data {
                        
                        do {
                            
                            let decodeResult = try JSONDecoder().decode(SearchResult.self, from: data)
                            completion(.success(decodeResult))
                            
                        } catch {
                            
                            completion(.failure(.decodeError))
                            
                        }
                    }
                    
                default:
                    
                    completion(.failure(.statusCodeError))
                    
                }
                
            }.resume()
            
        }
        
    }
 
}


// MARK: - Networking Error

extension KakaoService {
    
    enum NetworkingError: Error {
        
        case requestError
        case responseError
        case decodeError
        case statusCodeError
        
        var errorDescription: String {
            switch self {
            case .requestError:
                return "--Request Error--"
            case .responseError:
                return "--Response Error--"
            case .decodeError:
                return "--Strange Codable Model--"
            case .statusCodeError:
                return "--StatusCode is not contain 200...299--"
            }
        }
        
        func descriptionPrint() {
            print(errorDescription)
        }
        
    }
    
}

// MARK: - Request Case

extension KakaoService {
    
    enum Sort: String {
        case accuracy // 정확도순
        case recency // 최신순
    }
    
}

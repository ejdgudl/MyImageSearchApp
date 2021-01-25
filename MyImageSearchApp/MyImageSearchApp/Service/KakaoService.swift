//
//  KakaoService.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import Foundation
import Alamofire

final class KakaoService {
    
    // MARK: - Properties
    
    static let shared = KakaoService()
    
    private let baseURL = "https://dapi.kakao.com/v2/search/image"
    
    // MARK: - Life Cycle
    
    private init() { }
    
    // MARK: - Helpers
    
    func getImages(keyward: String, sort: Sort = .accuracy, page: Int = 1, completion: @escaping (Result<SearchResult, NetworkingError>) -> () ) {
        
        let params: [String: Any] = [
            "query": keyward,
            "sort": sort.rawValue,
            "page": page,
            "size": "30"
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 26a064bb00e0f331a0f853ceea59fd4c",
        ]
        
        AF.request(baseURL, method: .get, parameters: params, headers: headers).responseData { (res) in
            
            debugPrint(res)
            
            guard res.error == nil else {
                completion(.failure(.requestError))
                return
            }
            
            guard let statusCode = res.response?.statusCode else {
                completion(.failure(.responseError))
                return
            }
            
            switch statusCode {
            
            case 200...299:
                
                if let data = res.data {
                    
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

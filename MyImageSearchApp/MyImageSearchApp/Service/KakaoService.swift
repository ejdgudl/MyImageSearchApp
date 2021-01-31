//
//  KakaoService.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/25.
//

import UIKit
import Alamofire
import RxSwift

protocol KakaoServiceable {
    
    var baseURL: String { get set }
    func getImages(keyward: String, sort: Sort, page: Int, completion: @escaping (Result<SearchResult, NetworkingError>) -> ())
    func getImagesWithRX(keyward: String, sort: Sort, page: Int) -> Observable<SearchResult>
    
}

/// 개발 response
final class KakaoServiceStub: KakaoServiceable {
    
    // MARK: - Properties
    
    var baseURL = "https://dapi.kakao.com/v2/search/image"
    
    // MARK: - Helpers
    
    func getImages(keyward: String, sort: Sort, page: Int, completion: @escaping (Result<SearchResult, NetworkingError>) -> ()) {
        do {
            let decodeResult = try JSONDecoder().decode(SearchResult.self, from: SampleData.documents)
            completion(.success(decodeResult))
        } catch {
            completion(.failure(.decodeError))
        }
    }
    
    // RX
    func getImagesWithRX(keyward: String, sort: Sort, page: Int) -> Observable<SearchResult> {
        
        return Observable.create { (observer) -> Disposable in
            
            self.getImages(keyward: keyward, sort: sort, page: page) { (res) in
                
                switch res {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                    
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create()
            
        }
    }
}

/// 실 서버 response
final class KakaoService: KakaoServiceable {
    
    // MARK: - Properties
    
    var baseURL = "https://dapi.kakao.com/v2/search/image"
    
    // MARK: - Helpers
    
    func getImages(keyward: String, sort: Sort, page: Int, completion: @escaping (Result<SearchResult, NetworkingError>) -> () ) {
        
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
    
    // RX
    func getImagesWithRX(keyward: String, sort: Sort, page: Int) -> Observable<SearchResult> {
        
        return Observable.create { (observer) -> Disposable in
            
            self.getImages(keyward: keyward, sort: sort, page: page) { (res) in
                
                switch res {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
                
            }
            
            return Disposables.create()
            
        }
    }
    
}


// MARK: - Networking Error

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

// MARK: - Request Case

enum Sort: String {
    case accuracy // 정확도순
    case recency // 최신순
}

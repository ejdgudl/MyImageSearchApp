//
//  Alert.swift
//  MyImageSearchApp
//
//  Created by 김동현 on 2021/01/28.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    
    private init () { }
    
    // MARK: - 검색 결과 없음
    
    func noResult(vc: UIViewController) {
        let alert = UIAlertController(title: "검색 결과 없음", message: "검색어를 확인해 주세요", preferredStyle: .alert)
        let ok = UIAlertAction(title: "닫기", style: .cancel)
        
        alert.addAction(ok)
        vc.present(alert, animated: true)
    }
    
}


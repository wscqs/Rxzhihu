//
//  HTTPManager.swift
//  Rxzhihu
//
//  Created by mba on 16/12/26.
//  Copyright © 2016年 陈秋松. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper
import AlamofireObjectMapper

class HTTPManager {
    static let HTTPManagerErrorDoamin = "HTTPManagerErrorDomain"
    
    static func request<T: Mappable>(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parametrers: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil) -> Observable<T>
    {
        return Observable.create{ (observer) -> Disposable in
            let dataRequest = SessionManager.default.request(url, method: method, parameters: parametrers, encoding: encoding, headers: headers)
            
            
            dataRequest.responseObject{ (response: DataResponse<T>) in
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        observer.onNext(data)
                        observer.onCompleted()
                    }else {
                        let error = NSError(domain: HTTPManagerErrorDoamin, code: 0, userInfo: nil)
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            
            }
            
            return Disposables.create {
                dataRequest.cancel()
            }
        }
    }
}

//
//  URLRequest+Extension.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 5.02.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Codable> {
    let url: URL
}

extension URLRequest {
    static func load<T>(resource: Resource<T>) -> Observable<T?> {
        return Observable.from([resource.url])
            .flatMap { url -> Observable<Data> in
                let request = URLRequest(url: url)
                return URLSession.shared.rx.data(request: request)
            }.map { data -> T? in
                return try? JSONDecoder().decode(T.self, from: data)
            }.asObservable()
    }
}

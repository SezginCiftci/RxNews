//
//  String+Extension.swift
//  RxNews
//
//  Created by Sezgin Çiftci on 7.02.2023.
//

import Foundation

extension String {
    func convertString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let actualDate = dateFormatter.date(from: self) ?? .now
        dateFormatter.dateFormat = "dd MMM HH:mm"
        let dateString = dateFormatter.string(from: actualDate)
        return dateString
    }
}

//
//  String+Extension.swift
//  MovieArchive
//
//  Created by Emre Çakır on 16.08.2023.
//

import Foundation

extension String {
    func dateFormatted() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return self
        }
    }
}

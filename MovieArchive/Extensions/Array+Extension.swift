//
//  Array+Extension.swift
//  MovieArchive
//
//  Created by Emre Çakır on 11.08.2023.
//

import Foundation

extension Array where Element: Equatable {
    mutating func remove(element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}

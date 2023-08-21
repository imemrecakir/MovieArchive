//
//  UIImage+Extension.swift
//  MovieArchive
//
//  Created by Emre Çakır on 18.08.2023.
//

import UIKit

extension UIImage {
    func setImageWithBackground(backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        backgroundColor.setFill()
        let rect = CGRect(origin: .zero, size: self.size)
        let path = UIBezierPath(arcCenter: CGPoint(x:rect.midX, y:rect.midY), radius: rect.midX, startAngle: 0, endAngle: 6.28319, clockwise: true)
        path.fill()
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

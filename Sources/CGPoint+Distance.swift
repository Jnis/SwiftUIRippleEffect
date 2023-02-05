//
//  File.swift
//  
//
//  Created by Yanis Plumit on 05.02.2023.
//

import Foundation

internal extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

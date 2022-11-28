//
//  File.swift
//  
//
//  Created by Alain Stulz on 28.11.22.
//

import Foundation

internal extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
}

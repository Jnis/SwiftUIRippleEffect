//
//  RippleViewModel.swift
//  
//
//  Created by Alain Stulz on 28.11.22.
//

import SwiftUI

public class RippleViewModel: ObservableObject {
    internal var touchDown: ((_ touchPoint: CGPoint) -> Void)?
    internal var touchMove: ((_ touchPoint: CGPoint) -> Void)?
    internal var touchUp: ((_ touchPoint: CGPoint) -> Void)?
    internal var isTouchHandling = false
    
    public init() { }
}

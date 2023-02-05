//
//  RippleViewModel.swift
//  
//
//  Created by Yanis Plumit on 05.02.2023.
//

import SwiftUI

public class RippleViewModel: ObservableObject {
    internal var touchDown: ((_ touchPoint: CGPoint) -> Void)?
    internal var touchMove: ((_ touchPoint: CGPoint) -> Void)?
    internal var touchUp: ((_ touchPoint: CGPoint) -> Void)?
    internal var isTouchHandling = false
    
    public init() { }
}

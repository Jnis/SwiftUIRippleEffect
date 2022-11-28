//
//  File.swift
//  
//
//  Created by Alain Stulz on 28.11.22.
//

import SwiftUI

struct RippleViewModifier: ViewModifier {
    let color: Color
    let maxScale: CGFloat?
    let viewModel: RippleViewModel
    let clipShape: any Shape
    
    init(color: Color, maxScale: CGFloat? = 0.7, viewModel: RippleViewModel, clipShape: any Shape) {
        self.color = color
        self.maxScale = maxScale
        self.viewModel = viewModel
        self.clipShape = clipShape
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                AnyView(
                    SwiftUIRippleView(rippleViewModel: viewModel, color: UIColor(color), maxScale: maxScale)
                        .clipShape(clipShape)
                )
            )
    }
}

//
//  File.swift
//  
//
//  Created by Alain Stulz on 28.11.22.
//

import SwiftUI

struct RippleViewModifier: ViewModifier {
    let color: Color
    let viewModel: RippleViewModel
    let clipShape: any Shape
    
    func body(content: Content) -> some View {
        content
            .overlay(
                AnyView(
                    SwiftUIRippleView(rippleViewModel: viewModel, color: UIColor(color))
                        .clipShape(clipShape)
                )
            )
    }
}

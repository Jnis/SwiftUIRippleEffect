//
//  RippleViewModifier.swift
//  
//
//  Created by Yanis Plumit on 05.02.2023.
//

import Foundation
import SwiftUI

struct RippleViewModifier<V>: ViewModifier where V: RippleUIViewProtocol {
    let rippleViewModel: RippleViewModel
    let viewConfiguration: V.ConfigurationModel
    let clipShape: any Shape

    func body(content: Content) -> some View {
        content
            .overlay(
                AnyView(
                    RippleUIViewRepresenter<V>(rippleViewModel: rippleViewModel, viewConfiguration: viewConfiguration)
                        .clipShape(clipShape)
                )
            )
    }
}

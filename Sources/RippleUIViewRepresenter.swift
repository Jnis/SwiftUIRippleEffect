//
//  RippleUIViewRepresenter.swift
//  
//
//  Created by Yanis Plumit on 05.02.2023.
//

import Foundation
import SwiftUI
import UIKit

struct RippleUIViewRepresenter<V>: UIViewRepresentable where V: RippleUIViewProtocol {
    let rippleViewModel: RippleViewModel
    let viewConfiguration: V.ConfigurationModel
    
    func makeUIView(context: Context) -> UIView {
        let view = V.init(configuration: self.viewConfiguration)
        rippleViewModel.touchDown = {[weak view] touchPoint in
            view?.touchDown(touchPoint: touchPoint)
        }
        rippleViewModel.touchMove = {[weak view] touchPoint in
            view?.touchMove(touchPoint: touchPoint)
        }
        rippleViewModel.touchUp = {[weak view] touchPoint in
            view?.touchUp(touchPoint: touchPoint)
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

//
//  View+Ripple.swift
//
//  Created by Yanis Plumit on 21.11.2022.
//

import Foundation
import SwiftUI
import ViewOnTouch

public enum RippleViewGestureState {
    case started
    case moved
    case ended
}

public protocol RippleUIViewProtocol: UIView {
    associatedtype ConfigurationModel
    init(configuration: ConfigurationModel)
    func touchDown(touchPoint: CGPoint)
    func touchMove(touchPoint: CGPoint)
    func touchUp(touchPoint: CGPoint)
}

public extension View {
    
    /// Custom ripple effect
    func rippleEffect<V>(_ rippleViewModel: RippleViewModel,
                            viewType: V.Type,
                            viewConfiguration: V.ConfigurationModel,
                            clipShape: any Shape) -> some View where V: RippleUIViewProtocol {
        modifier(RippleViewModifier<V>(rippleViewModel: rippleViewModel, viewConfiguration: viewConfiguration, clipShape: clipShape))
    }
    
    /// Default ripple effect
    func rippleEffect(color: Color, fillPercent: CGFloat = 0.7, rippleViewModel: RippleViewModel, clipShape: any Shape) -> some View {
        rippleEffect(rippleViewModel,
                     viewType: DefaultRippleUIView.self,
                     viewConfiguration: DefaultRippleUIView.ConfigurationModel(rippleColor: UIColor(color), fillPercent: fillPercent),
                     clipShape: clipShape)
    }
    
    func rippleTouchHandler(viewModel: RippleViewModel,
                            tapAction: (() -> Void)? = nil,
                            longGestureAction: ((CGPoint, RippleViewGestureState) -> Void)? = nil
    ) -> some View {
        self
            .onTouch(type: longGestureAction == nil ? .allWithoutLongGesture : .all,
                     perform: { location, event in
                switch event {
                case .started:
                    viewModel.isTouchHandling = true
                    viewModel.touchDown?(location)
                case .moved:
                    viewModel.touchMove?(location)
                case .ended:
                    viewModel.isTouchHandling = false
                    viewModel.touchUp?(location)
                case .tapGesture where !viewModel.isTouchHandling:
                    viewModel.touchDown?(location)
                    viewModel.touchUp?(location)
                    tapAction?()
                case .longGestureStarted:
                    longGestureAction?(location, .started)
                case .longGestureMoved:
                    longGestureAction?(location, .moved)
                case .longGestureEnded:
                    longGestureAction?(location, .ended)
                default:
                    break
                }
            })
    }
}

public extension View {
    @available(*, deprecated, renamed: "rippleEffect")
    func addRipple(color: Color, fillPercent: CGFloat = 0.7, rippleViewModel: RippleViewModel, clipShape: any Shape) -> some View {
        rippleEffect(color: color, fillPercent: fillPercent, rippleViewModel: rippleViewModel, clipShape: clipShape)
    }
    
    @available(*, deprecated, renamed: "rippleTouchHandler")
    func addRippleTouchHandler(viewModel: RippleViewModel, tapAction: (() -> Void)? = nil, longGestureAction: ((CGPoint, RippleViewGestureState) -> Void)? = nil
    ) -> some View {
        rippleTouchHandler(viewModel: viewModel, tapAction: tapAction, longGestureAction: longGestureAction)
    }
}

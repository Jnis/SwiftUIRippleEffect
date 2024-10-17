//
//  View+Ripple.swift
//
//  Created by Yanis Plumit on 21.11.2022.
//

import Foundation
import SwiftUI
import ViewOnTouch

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
    
    /// iOS 18 and newer (see also `rippleTouchHandler17AndOlder`)
    /// - must be outside Button's label
    /// -  must be after `onTapGesture` and `onLongPressGesture`
    func rippleTouchHandler(viewModel: RippleViewModel) -> some View {
        if #available(iOS 18.0, *) {
            return self
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if !viewModel.isTouchHandling {
                                viewModel.isTouchHandling = true
                                viewModel.touchDown?(value.location)
                            }
                            viewModel.touchMove?(value.location)
                        }
                        .onEnded { value in
                            viewModel.isTouchHandling = false
                            viewModel.touchUp?(value.location)
                        }
            )
        } else {
            return self
        }
    }
    
    /// iOS 17 and older
    /// - must  be inside Button's label
    /// - must be before `onTapGesture` and `onLongPressGesture`
    func rippleTouchHandler17AndOlder(viewModel: RippleViewModel) -> some View {
        if #available(iOS 18.0, *) {
            return self
        } else {
            return self
                .onTouch(type: .allWithoutLongGesture,
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
                    case .firstTouch: break
                    case .tapGesture: break
                    case .longGestureStarted: break
                    case .longGestureMoved: break
                    case .longGestureEnded: break
                    default:
                        break
                    }
                })
        }
    }
}

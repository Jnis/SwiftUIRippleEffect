//
//  Button3.swift
//  Examples
//
//  Created by Yanis Plumit on 21.11.2022.
//

import SwiftUI
import SwiftUIRippleEffect

extension Button3 {
    struct UIModel {
        let title: String
        let bgColor: Color = Color.orange
        let rippleColor: Color = Color.indigo
    }
    
    struct Style: ButtonStyle {
        let uiModel: UIModel
        let longPressAction: (() -> Void)?
        
        func makeBody(configuration: Self.Configuration) -> some View {
            let rippleViewModel = RippleViewModel()
            ZStack {
                uiModel.bgColor.cornerRadius(12)
                
                Color.clear
                    .rippleEffect(color: uiModel.rippleColor,
                                  viewModel: rippleViewModel,
                                  clipShape: RoundedRectangle(cornerRadius: 12))
                
                VStack(spacing: 7) {
                    ZStack {
                        Circle().foregroundColor(.gray.opacity(0.2))
                        Image(systemName: "heart.fill")

                                .resizable()
                                .padding(.all, 10)
                        
                    }
                    .frame(width: 64, height: 64)
                    .padding(.top, 10)
                    
                    Text(uiModel.title)
                }
            }
            .addRippleTouchHandler(viewModel: rippleViewModel,
                                   longGestureAction: longPressAction == nil ? nil : {_, state in
                if state == .started {
                    longPressAction?()
                }
            })
            .frame(width: 120, height: 120)
        }
    }
}

struct Button3: View {
    let uiModel: UIModel
    let action: () -> Void
    let longPressAction: (() -> Void)?
    
    var body: some View {
        Button(action: {
            action()
        }, label: {})
        .buttonStyle(Button3.Style(uiModel: uiModel, longPressAction: longPressAction))
    }
}

struct Button3_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button3(uiModel: .init(title: "Title"), action: {}, longPressAction: {})
                .padding()
        }.background(.black)
    }
}

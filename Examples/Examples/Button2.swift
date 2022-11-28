//
//  Button2.swift
//  Examples
//
//  Created by Yanis Plumit on 21.11.2022.
//

import SwiftUI
import SwiftUIRippleEffect

extension Button2 {
    struct UIModel {
        let title: String
        let bgColor: UIColor
        let rippleColor: UIColor
    }
    
    struct Style: ButtonStyle {
        let uiModel: UIModel
        let rippleViewModel: RippleViewModel
        
        func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .background(
                    Capsule()
                        .foregroundColor(.yellow)
                        .rippleEffect(color: .blue,
                                      maxScale: 1.0,
                                      viewModel: rippleViewModel,
                                      clipShape: Capsule())
                )
        }
    }
}

struct Button2: View {
    
    let uiModel: UIModel
    let action: () -> Void
    
    var body: some View {
        let rippleViewModel = RippleViewModel()
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                Text(uiModel.title).padding()
                Spacer()
            }
            .addRippleTouchHandler(viewModel: rippleViewModel)
        })
        .buttonStyle(Button2.Style(uiModel: uiModel, rippleViewModel: rippleViewModel))
    }
}

struct Button2_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button2(uiModel: .init(title: "Title", bgColor: .yellow, rippleColor: .blue), action: {})
        }.padding()
        
    }
}

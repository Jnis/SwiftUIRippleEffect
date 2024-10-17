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
        let rippleViewModel: RippleViewModel
        
        func makeBody(configuration: Self.Configuration) -> some View {
            ZStack {
                uiModel.bgColor.cornerRadius(12)
                
                Color.clear
                    .rippleEffect(color: uiModel.rippleColor,
                                  rippleViewModel: rippleViewModel,
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
            .frame(width: 120, height: 120)
            .rippleTouchHandler17AndOlder(viewModel: rippleViewModel)
        }
    }
}

struct Button3: View {
    @State private var rippleViewModel = RippleViewModel()
    let uiModel: UIModel
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {})
        .buttonStyle(Button3.Style(uiModel: uiModel, rippleViewModel: rippleViewModel))
        .rippleTouchHandler(viewModel: rippleViewModel)
    }
}

struct Button3_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button3(uiModel: .init(title: "Title"), action: {})
                .padding()
        }.background(.black)
    }
}

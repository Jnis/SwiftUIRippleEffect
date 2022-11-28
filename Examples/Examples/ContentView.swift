//
//  ContentView.swift
//  Examples
//
//  Created by Yanis Plumit on 21.11.2022.
//

import SwiftUI
import SwiftUIRippleEffect

struct ContentView: View {
    var body: some View {
        VStack {
            // static view
            ZStack {
                Color.gray.opacity(0.1)
                VStack {
                    button1
                    
                    Button2(uiModel: .init(title: "Title 2",
                                           bgColor: .yellow,
                                           rippleColor: .blue),
                            action: { print("Action2") })
                        .padding()
                    
                    Button3(uiModel: .init(title: "Title 3"),
                            action: { print("Action3") },
                            longPressAction: { print("Long Action3") })
                }
            }
            
            // scroll view
            ScrollView {
                button1
                
                Button2(uiModel: .init(title: "Title 2",
                                       bgColor: .yellow,
                                       rippleColor: .blue),
                        action: { print("Action2") })
                    .padding()
                
                Button3(uiModel: .init(title: "Title 3"),
                        action: { print("Action3") },
                        longPressAction: { print("Long Action3") })
            }
        }
    }
    
    var button1: some View {
        VStack {
            let rippleViewModel = RippleViewModel() // 1
            Button(action: {
                
            }, label: {
                HStack {
                    Spacer()
                    Text("Title 1").padding()
                    Spacer()
                }
                .addRippleTouchHandler(viewModel: rippleViewModel) // 2
            })
            .buttonStyle(EmptyStyle())
            .background(
                Capsule()
                    .foregroundColor(.yellow)
                    .rippleEffect(color: .gray,
                                  viewModel: rippleViewModel,
                                  clipShape: Capsule()) // 3
            )
        }.padding()
    }
}

struct EmptyStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

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
                DemoView()
            }
            
            // scroll view
            ScrollView {
                DemoView()
            }
        }
    }
    
}

struct DemoView: View {
    
    var body: some View {
        VStack {
            PlaneView()
            
            MyButton(action: {
                print("Action1")
            }, label: {
                HStack {
                    Spacer()
                    Text("Button 1").padding()
                    Spacer()
                }
            })
            .padding()
            
            Button2(uiModel: .init(title: "Button 2",
                                   bgColor: .yellow,
                                   rippleColor: .blue),
                    action: { print("Action2") })
                .padding()
            
            Button3(uiModel: .init(title: "Button 3"),
                    action: { print("Action3") })
        }
    }
}

struct PlaneView: View {
    @State private var rippleViewModel = RippleViewModel() // 1
    
    var body: some View {
        VStack {
            Text("Plane view")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .rippleTouchHandler17AndOlder(viewModel: rippleViewModel) // 2 (iOS17 and older)
        .onTapGesture {
            print("Tap gesture")
        }
        .onLongPressGesture {
            print("Long gesture")
        }
        .rippleTouchHandler(viewModel: rippleViewModel) // 2 (iOS18)
        .background(
            Rectangle()
                .foregroundColor(.blue)
                .rippleEffect(color: .red,
                              rippleViewModel: rippleViewModel,
                              clipShape: Rectangle()) // 3
        )
    }
}

struct MyButton<V: View>: View {
    @State private var rippleViewModel = RippleViewModel() // 1
    
    let action: () -> Void
    let label: () -> V
    
    var body: some View {
        VStack {
            Button(action: {
                action()
            }, label: {
                label()
                    .contentShape(Rectangle())
                    .rippleTouchHandler17AndOlder(viewModel: rippleViewModel) // 2 (iOS17 and older)
            })
            .buttonStyle(EmptyStyle())
            .rippleTouchHandler(viewModel: rippleViewModel) // 2 (iOS18)
            .background(
                Capsule()
                    .foregroundColor(.yellow)
                    .rippleEffect(color: .gray,
                                  rippleViewModel: rippleViewModel,
                                  clipShape: Capsule()) // 3
            )
        }
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

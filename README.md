# SwiftUIRippleEffect

Cool ripple effect on you SwiftUI view.

<table>
<tr>
<td><img src="Examples/demo1.gif"/></td>
</tr>
</table>

## Features
- easy to use for regular button
- long press and gesture support

# Installing
Swift Package Manager:
```
https://github.com/Jnis/SwiftUIRippleEffect.git
```

# Usage

1) Make a shared RippleViewModel
2) Add touch handler by .rippleTouchHandler method 
3) Add ripple effect view by .rippleEffect method

``` swift
import SwiftUIRippleEffect

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
```

You can find more examples inside `/Examples` folder.

## Notes
- `.rippleTouchHandler` must not be inside Button's label
- `.rippleTouchHandler` must be after `onTapGesture` and `onLongPressGesture`
- use `.rippleTouchHandler17AndOlder` for old iOS versions.

# License 
MIT

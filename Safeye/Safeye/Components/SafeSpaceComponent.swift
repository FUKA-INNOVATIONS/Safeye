//
//  SafeSpaceComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import SwiftUI

struct SafeSpaceComponent: View {
    let size: CGFloat
    let own: Bool
    let name: String
    init (size: CGFloat, own: Bool, name: String) {
        self.size = size
        self.own = own
        self.name = name
    }
    @State var showName: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                if own {
                    AnimationLottieView(lottieJson: "safe-place-own", loopOnce: true)
                        .frame(width: size, height: size, alignment: .center)
                        .onTapGesture {
                            showName.toggle()
                        }
                } else {
                    AnimationLottieView(lottieJson: "safe-place-trusted")
                        .frame(width: size, height: size, alignment: .center)
                        .onTapGesture {
                            showName.toggle()
                        }
                }
                
                Circle()
                    .stroke(.blue, lineWidth: 2)
                    .frame(width: size + 5, height: size + 5)
            }
            
            if showName { Text(name) }
        }
        .aspectRatio(contentMode: .fill)
    }
}

struct SafeSpaceComponent_Previews: PreviewProvider {
    static var previews: some View {
        SafeSpaceComponent(size: 100, own: true, name: "Test")
    }
}

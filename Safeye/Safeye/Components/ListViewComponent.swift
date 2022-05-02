//
//  ListViewComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.


import SwiftUI

struct ListViewComponent: View {
    @EnvironmentObject var appState: Store
    
    let item: String
    let size: CGFloat
    init (item: String, size: CGFloat) {
        self.item = item
        self.size = size
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                if item == "avatar" {
                    ForEach(0..<7) {_ in
                        AvatarComponent(size: size)
                    }.padding(5)
                } else if item == "safeSpace" {
                    ForEach(appState.safePlaces) {safePlace in
                        SafeSpaceComponent(size: size, own: true, name: safePlace.name)
                    }.padding(5)
                }
            }
        }.padding()
    }
}

struct ListViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListViewComponent(item: "avatar", size: 50)
    }
}

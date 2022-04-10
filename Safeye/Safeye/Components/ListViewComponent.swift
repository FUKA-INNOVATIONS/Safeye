//
//  ListViewComponent.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//

import SwiftUI

struct ListViewComponent: View {
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
                    ForEach(0..<7) {_ in
                        SafeSpaceComponent(size: size)
                    }.padding(5)
                }
            }
        }.padding(15)
        
    }
}

struct ListViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListViewComponent(item: "avatar", size: 50)
    }
}

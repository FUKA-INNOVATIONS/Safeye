//
//  ListViewComponent.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//

import SwiftUI

struct ListViewComponent: View {
        var body: some View {
            ScrollView(.horizontal, showsIndicators: true) {
                HStack {
                ForEach(0..<7) {_ in
                    AvatarComponent(size: 50)
                }.padding(5)
                    //icon is temporary, will have to change
                    Image("icon-add")
                }
            }.padding(10)
                
        }
}

struct ListViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        ListViewComponent()
    }
}

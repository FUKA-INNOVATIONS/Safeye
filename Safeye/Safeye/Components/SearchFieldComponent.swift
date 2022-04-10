//
//  SearchFieldComponent.swift
//  Safeye
//
//  Created by gintare on 9.4.2022.
//

import SwiftUI

struct SearchFieldComponent: View {
    @Binding var searchInput: String
    var body: some View {
        HStack {
            HStack {
                //the icons need to be changed to FS Symbols
                
                
                Image("icon-search").padding(8)
                TextField("TC code...", text: $searchInput)
                Button(action: {
                    print("search")
                })
                { Image("icon-clear") }.padding(8)
            }
            .background(.bar)
            .frame(width: 280, height: 20, alignment: .center)
            Button(action: { print("Cancelled") }, label: {Text("Cancel")})
            
        }
        .frame(width: 400, height: 80, alignment: .center)
    }
}

struct SearchFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldComponent(searchInput: .constant("126TH89AK"))
    }
}

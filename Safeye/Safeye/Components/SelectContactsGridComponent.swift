//
//  SelectContactsGridComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SelectContactGridComponent: View {
    let layout = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
        var body: some View {
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHGrid(rows: layout) {
                    ForEach(0..<10) {_ in
                        SelectContactComponent()
                    }
                }
            }
                
        }
}

struct SelectContactGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactGridComponent()
    }
}

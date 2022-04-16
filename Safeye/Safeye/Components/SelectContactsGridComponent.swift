//
//  SelectContactsGridComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SelectContactGridComponent: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appStore: Store
    @State var selectedContacts = [String]()
    
    let layout = [
        GridItem(.fixed(70)),
        GridItem(.fixed(70))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: layout) {
                ForEach(appStore.connectionPofiles) { profile in
                    SelectContactComponent(profileDetails: profile)
                }
            }
        }
        .onAppear {
            
        }
    }
}

struct SelectContactGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactGridComponent()
    }
}

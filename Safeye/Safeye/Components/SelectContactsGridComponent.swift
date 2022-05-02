//
//  SelectContactsGridComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import SwiftUI

struct SelectContactGridComponent: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appStore: Store
    @State var selectedContacts = [String]()
    
    let layout = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        //        ScrollView(.vertical, showsIndicators: true) {
        //            LazyHGrid(rows: layout) {
        if appStore.connectionPofiles.isEmpty {
            Text("You have not added any contacts.") // TODO: translation
        } else {
            HStack {
                Button {
                    appStore.eventSelctedContacts.removeAll()
                } label: {
                    Text("Remove all contacts") // translation
                        .font(.caption)
                }
                Spacer()
                Button {
                    appStore.eventSelctedContacts = appStore.connectionPofiles
                } label: {
                    Text("Select all contacts") // translation
                        .font(.caption)
                }
            }.buttonStyle(BorderlessButtonStyle())
            
            ForEach(appStore.connectionPofiles) { profile in
                Section {
                    SelectContactComponent(profileDetails: profile)
                }
                .onAppear{
                    FileVM.fetchPhoto(avatarUrlFetched: profile.avatar, isTrustedContactPhoto: true)
                }
            }
        }
//     }
//   }
    }
}

struct SelectContactGridComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactGridComponent()
    }
}

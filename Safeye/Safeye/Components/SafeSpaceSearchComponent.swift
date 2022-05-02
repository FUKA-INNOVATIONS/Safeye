//
//  SafeSpaceSearchComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.


import SwiftUI

struct SafeSpaceSearchComponent: View {
    @Binding var searchText: String
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                //the icons need to be changed to FS Symbols
                
                Image(systemName: "magnifyingglass").padding(8)
                TextField("Address", text: $searchText)
                Button(action: {
                    searchText = ""
                    
                })
                { Image(systemName: "xmark.circle") }.padding(8)
            }
            .background(.bar)
            .cornerRadius(10)
            .frame(width: 340, height: 20, alignment: .center)
        }
        .frame(width: 400, height: 40, alignment: .center)
    }
}

struct SafeSpaceSearchComponent_Previews: PreviewProvider {
    static var previews: some View {
        SafeSpaceSearchComponent(searchText: .constant("Helsinki"))
    }
}


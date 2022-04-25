//
//  SearchFieldComponent.swift
//  Safeye
//
//  Created by gintare on 9.4.2022.
//  Edit by gintare 10.4.2022.

import SwiftUI

struct SearchFieldComponent: View {
    @Binding var searchInput: String
    
    var translationManager = TranslationService.shared
    
    var body: some View {
        HStack {
            HStack {
                //the icons need to be changed to FS Symbols
                
                
                Image("icon-search").padding(8)
                TextField(translationManager.codeInput, text: $searchInput)
                Button(action: {
                    searchInput = ""
                })
                { Image(systemName: "xmark.circle") }.padding(8)
            }
            .background(.bar)
            .cornerRadius(10)
            .frame(width: 340, height: 20, alignment: .center)
            
            
        }
        .frame(width: 400, height: 80, alignment: .center)
    }
}

struct SearchFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        SearchFieldComponent(searchInput: .constant("126TH89AK"))
    }
}

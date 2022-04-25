//
//  SelectContactComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SelectContactComponent: View {
    @State var profileDetails: ProfileModel
    @EnvironmentObject var appState: Store
    @State var selected = false
    
    var translationManager = TranslationService.shared

    let remove = TranslationService.shared.removeContactBtn
    
    var body: some View {
        VStack{
            AvatarComponent(size: 30).padding(.top)
            Text("\(profileDetails.fullName)")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.white)
                .padding(.bottom)
                .frame(width: 120, height: 20, alignment: .center)
            Button("\(selected ? Text(translationManager.removeContactBtn) : Text(translationManager.addContactBtn))") {
                if selected { appState.eventSelctedContacts =  appState.eventSelctedContacts.filter { $0.id != profileDetails.id } } else { appState.eventSelctedContacts.append(profileDetails) }
                selected.toggle()
            }
            .foregroundColor(Color.white)
            //.position(y: -10)
        }
        .fixedSize()
        .background(.gray)
        .padding([.bottom], 10)
        
    }
}

/*struct SelectContactComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactComponent()
    }
}*/

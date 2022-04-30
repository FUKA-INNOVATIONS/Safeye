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
    @EnvironmentObject var FileVM: FileViewModel
    @State var selected = false
    @State var photo: UIImage?
    
    var translationManager = TranslationService.shared

    let remove = TranslationService.shared.removeContactBtn
    
    var body: some View {
        
        
        HStack {
            Image(systemName: "person.fill.checkmark").foregroundColor(selected ? .blue : .gray)
            Text(profileDetails.fullName).foregroundColor(selected ? .blue : .gray)
            Spacer()
            Button("\(selected ? Text(translationManager.removeContactBtn) : Text(translationManager.addContactBtn))") {
                if selected { appState.eventSelctedContacts =  appState.eventSelctedContacts.filter { $0.id != profileDetails.id } } else { appState.eventSelctedContacts.append(profileDetails) }
                selected.toggle()
            }
        }
        
        
//        VStack{
//            if photo != nil {
//                ProfileImageComponent(size: 30, avatarImage: photo!)
//            } else {
//                ProgressView()
//            }
//            //AvatarComponent(size: 30).padding(.top)
//            Text("\(profileDetails.fullName)")
//                .font(.system(size: 13, weight: .semibold))
//                .foregroundColor(.white)
//                .padding(.bottom)
//                .frame(width: 120, height: 20, alignment: .center)
//            Button("\(selected ? Text(translationManager.removeContactBtn) : Text(translationManager.addContactBtn))") {
//                if selected { appState.eventSelctedContacts =  appState.eventSelctedContacts.filter { $0.id != profileDetails.id } } else { appState.eventSelctedContacts.append(profileDetails) }
//                selected.toggle()
//            }
//            .foregroundColor(Color.white)
//            //.position(y: -10)
//        }
//        .onAppear {
//            photo = appState.trustedContactPhoto
//        }
//        .fixedSize()
//        .background(.gray)
//        .padding([.bottom], 10)
        
    }
}

/*struct SelectContactComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactComponent()
    }
}*/

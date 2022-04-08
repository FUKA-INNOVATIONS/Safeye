//
//  SelectContactComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SelectContactComponent: View {
    
        var body: some View {
            VStack{
                AvatarComponent(size: 40).padding(.top)
                Text("Name Surname")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .frame(width: 130, height: 30, alignment: .center)
            }
            .fixedSize()
            .background(.gray)
            
        }
}

struct SelectContactComponent_Previews: PreviewProvider {
    static var previews: some View {
        SelectContactComponent()
    }
}




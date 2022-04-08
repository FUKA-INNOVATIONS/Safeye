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
                AvatarComponent(size: 60).padding(.top)
                Text("Name Surname")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.bottom)
                    .frame(width: 150, height: 40, alignment: .center)
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




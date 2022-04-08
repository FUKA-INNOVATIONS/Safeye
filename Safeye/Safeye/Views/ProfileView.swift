//
//  ProfileView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.blue
            
            Image(systemName: "person.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

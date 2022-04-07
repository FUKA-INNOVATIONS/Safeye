//
//  PanicButtonComponent.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 7.4.2022.
//

import SwiftUI
import CoreMedia

struct PanicButtonComponent: View {
    
    var body: some View {
        Button(action: {
            print("Round Action")
            }) {
                Text("PANIC")
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.black)
                    .font(.system(size: 55))
                    .background(Color.red)
                    .clipShape(Circle())
        }
    }
}



struct PanicButtonComponent_Preview: PreviewProvider {
    static var previews: some View {
        PanicButtonComponent()
    }
}


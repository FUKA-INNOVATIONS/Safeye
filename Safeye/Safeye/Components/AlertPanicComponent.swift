//
//  AlertPanicComponent.swift
//  Safeye
//
//  Created by FUKA on 22.4.2022.
//

import SwiftUI

struct AlertPanicComponent: View {
    
    var body: some View {
        VStack {
            Group {
                Image(systemName: "exclamationmark.triangle.fill").font(.system(size: 50, weight: .bold))
                Text("Friend needs your help!")
                    .multilineTextAlignment(.center)
                    .font(.title)
            }
            .foregroundColor(.red)
            
            /*ForEach(appState.panicPofiles) {
                Text($0.fullName)
            }*/
        }
    }
}

struct AlertPanicComponent_Previews: PreviewProvider {
    static var previews: some View {
        AlertPanicComponent()
    }
}

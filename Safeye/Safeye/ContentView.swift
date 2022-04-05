//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // var showEmailField = InputFieldComponent(title: "Email address", text: "")
    
    
    var body: some View {
        Section {
            // emailField
            InputFieldComponent(title: "Email address", text: "")
        }
    }
    

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  MapCurtainComponent.swift
//  Safeye
//
//  Created by iosdev on 9.4.2022.
//

import SwiftUI

struct MapCurtainComponent: View {
    var body: some View {
        
        VStack {
    
            HStack {
                Spacer()
                Text("This is the top")
                Spacer()
            }
            Spacer()
            
            Text("This is the bottom")
            
            Text("Drag this down").padding(15)
            
        }
        .background(Color.white)
        
    }
}

struct MapCurtainComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapCurtainComponent()
    }
}

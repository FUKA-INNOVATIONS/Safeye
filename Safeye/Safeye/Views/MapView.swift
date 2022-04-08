//
//  MapView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Color.gray
            
            Image(systemName: "map.fill")
                .foregroundColor(Color.white)
                .font(.system(size: 100.0))
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

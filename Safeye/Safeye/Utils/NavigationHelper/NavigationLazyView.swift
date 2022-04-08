//
//  NavigationLazyView.swift
//  Safeye
//
//  Created by Koulu on 8.4.2022.
//


/*
    Solution to problem: SwiftUI NavigationLink loads destination view immediately, without clicking
 */

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

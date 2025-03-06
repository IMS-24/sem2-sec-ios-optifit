//
//  LazyView.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 06.03.25.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

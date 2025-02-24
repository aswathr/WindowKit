//
//  WindowOverlayHelper.swift
//  WindowKit
//
//  Created by David Walter on 14.10.23.
//

import SwiftUI
import WindowSceneReader

struct WindowOverlayHelper<WindowContent>: ViewModifier where WindowContent: View {
    let identifier: String?
    @ViewBuilder let windowContent: () -> WindowContent
    let configure: ((inout WindowOverlayConfiguration) -> Void)?
    
    @State private var windowScene: UIWindowScene?
    
    func body(content: Content) -> some View {
        if let windowScene {
            content
                .windowOverlay(
                    identifier,
                    on: windowScene,
                    content: windowContent,
                    configure: configure
                )
        } else {
            content
                .captureWindowScene { windowScene in
                    self.windowScene = windowScene
                }
        }
    }
}

//
//  ScreenObserverUtil.swift
//  digimon app
//
//  Created by Caleb Merroto on 3/6/25.
//

import SwiftUI

class ScreenSizeObserver: ObservableObject {
    @Published var width: CGFloat = UIScreen.main.bounds.width
    @Published var height: CGFloat = UIScreen.main.bounds.height

    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleOrientationChange),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    @objc private func handleOrientationChange() {
        DispatchQueue.main.async {
            self.width = UIScreen.main.bounds.width
            self.height = UIScreen.main.bounds.height
        }
    }
}

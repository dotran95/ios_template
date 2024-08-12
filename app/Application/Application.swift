//
//  Application.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import UIKit

class Application {
    static let shared = Application()

    // MARK: - Properties
    private let authManager: AuthManager

    private init() {
        authManager = AuthManager.shared
    }

    func presentInitialScreen() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let story: UIStoryboard
            if self.authManager.user != nil {
                story = UIStoryboard(name: "Home", bundle: nil)
            } else {
                story = UIStoryboard(name: "Auth", bundle: nil)
            }
            window.rootViewController = story.instantiateInitialViewController()
        }
    }
    
    func onLogout() {
        authManager.onLogOut()
        presentInitialScreen()
    }
}

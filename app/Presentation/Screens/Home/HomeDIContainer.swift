//
//  HomeDIContainer.swift
//  app
//
//  Created by dotn on 15/8/24.
//

import UIKit

class HomeDIContainer {

    static func makeViewController() -> HomeVc {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "HomeVc") as? HomeVc,
                let usecase = Application.shared.appContainer.resolve(GetPostsUsecaseProtocol.self) else {
            fatalError("LoginDIContainer not found")
        }

        let viewModel = HomeViewModel(getPostsUsercase: usecase)
        vc.viewModel = viewModel
        return vc
    }

}

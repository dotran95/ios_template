//
//  SplashViewModel.swift
//  app
//
//  Created by dotn on 9/8/24.
//

import RxSwift
import RxCocoa

class SplashViewModel: ViewModel, ViewModelType {

    // MARK: - Properties
    private let userUsecase: GetUserUsecase

    struct Input { }

    struct Output {
        let loggedIn: PublishRelay<Bool>
    }

    // MARK: - Init
    init(userUsecase: GetUserUsecase) {
        self.userUsecase = userUsecase
    }

    func transform(input: Input) -> Output {

        let loggedIn = PublishRelay<Bool>()

        let userApi = userUsecase.call()

        userApi.subscribe(onSuccess: { user in
                loggedIn.accept(true)
                AuthManager.shared.user = user
            }, onFailure: { _ in
                loggedIn.accept(false)
            }).disposed(by: disposeBag)

        return Output(loggedIn: loggedIn)
    }
}

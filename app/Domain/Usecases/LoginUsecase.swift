//
//  LoginUsecase.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

protocol LoginUsecase {
    var repository: AuthRepository { get set }
    func call(username: String, password: String) -> Single<LoginResponse>
}

struct LoginUsecaseImpl: LoginUsecase {
    var repository: any AuthRepository

    func call(username: String, password: String) -> Single<LoginResponse> {
        return repository.login(username: username, password: password)
    }
}

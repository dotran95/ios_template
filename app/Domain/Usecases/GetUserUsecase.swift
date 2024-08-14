//
//  GetUserUsecase.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

protocol GetUserUsecase {
    var repository: UserRepository { get set }
    func call() -> Single<UserModel>
}

struct GetUserUsecaseImpl: GetUserUsecase {
    var repository: any UserRepository

    func call() -> Single<UserModel> {
        return repository.getUserInfo()
    }
}

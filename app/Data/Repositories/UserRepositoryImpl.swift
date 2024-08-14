//
//  UserRepositoryImpl.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

struct UserRepositoryImpl: UserRepository {

    var remoteDataSource: RemoteDataSource

    func getUserInfo() -> Single<UserModel> {
        return remoteDataSource.getUserInfo().map({ UserModel.fromApi(result: $0) })
    }
}

//
//  UserRepositoryImpl.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

struct UserRepositoryImpl: UserRepository {
    
    var remoteDataSource: RemoteDataSource
    
    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUserInfo() -> Single<UserModel> {
        return remoteDataSource.getUserInfo().map({ UserModel.fromApi(res: $0) })
    }
}

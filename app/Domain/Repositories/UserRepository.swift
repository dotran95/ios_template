//
//  UserRepository.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

protocol UserRepository {
    var remoteDataSource: RemoteDataSource { get set }
    func getUserInfo() -> Single<UserModel>
}

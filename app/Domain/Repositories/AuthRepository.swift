//
//  AuthRepository.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

protocol AuthRepository {
    var remoteDataSource: RemoteDataSource { get set }

    func login(username: String, password: String) -> Single<LoginResponse>
}

//
//  RemoteDataSource.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

protocol RemoteDataSource {
    func getUserInfo() -> Single<GetUserRespose>
    func login(params: LoginParams) -> Single<LoginResponse>
}

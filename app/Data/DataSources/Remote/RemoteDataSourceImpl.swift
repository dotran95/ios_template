//
//  RemoteDataSourceImpl.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift

struct RemoteDataSourceImpl: RemoteDataSource {
    
    func login(params: LoginParams) -> RxSwift.Single<LoginResponse> {
        return ApiConnection.share.request<LoginRespose>(target: Apis.login(body: params))
    }
    
    func getUserInfo() -> Single<GetUserRespose> {
        return ApiConnection.share.request<GetUserRespose>(target: Apis.getUserInfo)
    }
}

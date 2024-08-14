//
//  ApiConnection.swift
//  app
//
//  Created by dotn on 9/8/24.
//

import Moya
import RxSwift

public typealias ApiCompletion<T> = (_ result: Result<T, Error>) -> Void

final class ApiConnection {

    static let share = ApiConnection()

    private let apiProvider: ApiProvider<MultiTarget>

    private init() {
        apiProvider = ApiProvider(plugins: [
            AccessTokenPlugin(tokenClosure: { _ in "" })
        ])
    }

}

extension ApiConnection {

    func requestWithCancelable<T: Decodable>(target: TargetType,
                                             type: T.Type,
                                             completion: @escaping ApiCompletion<T>) -> any Cancellable {
        return apiProvider.request(MultiTarget(target)) { [weak self] result in
            self?.handleCompletionDecodeJson(result, type: type, completion: completion)
        }
    }

    func request<T: Decodable>(target: TargetType,
                               type: T.Type,
                               completion: @escaping ApiCompletion<T>) {
        apiProvider.request(MultiTarget(target)) { [weak self] result in
            self?.handleCompletionDecodeJson(result, type: type, completion: completion)
        }
    }

    private func handleCompletionDecodeJson<T: Decodable>(_ result: Result<Moya.Response, MoyaError>,
                                                          type: T.Type,
                                                          completion: @escaping ApiCompletion<T>) {
        do {
            let response = try result.get()
            let value = try JSONDecoder().decode(T.self, from: response.data)
            completion(.success(value))
        } catch {
            completion(.failure(error))
        }
    }

    // MARK: - Rx
    func request<T: Decodable>(target: TargetType) -> Single<T> {
        return apiProvider.rx.request(MultiTarget(target))
            .filterSuccessfulStatusCodes()
            .observe(on: MainScheduler.instance)
            .map(T.self)
    }

}

//
//  HomeViewModel.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import RxSwift
import RxCocoa

class HomeViewModel: ViewModel, ViewModelType {

    // MARK: - Properties
    private let getPostsUsercase: GetPostsUsecaseProtocol

    struct Input {
        let viewDidLoad: Driver<Void>
    }

    struct Output {
        let items: Driver<[PostModel]>
    }

    // MARK: - Init
    init(getPostsUsercase: GetPostsUsecaseProtocol) {
        self.getPostsUsercase = getPostsUsercase
    }

    func transform(input: Input) -> Output {

        let items = BehaviorRelay<[PostModel]>(value: [])

        input.viewDidLoad.flatMap { [weak self] () -> Driver<[PostModel]> in
            guard let self = self else {
                return Driver.just([])
            }
            return self.getPostsUsercase.excute(limit: 20, skip: 0)
                .trackError(to: self.errorSubject)
                .asDriver(onErrorJustReturn: [])
        }
        .drive(onNext: { posts in
            items.accept(posts)
        }).disposed(by: disposeBag)

        return Output(items: items.asDriver())
    }
}

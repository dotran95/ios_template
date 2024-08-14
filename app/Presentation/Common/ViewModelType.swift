//
//  ViewModelType.swift
//  app
//
//  Created by dotn on 9/8/24.
//

import RxRelay
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class ViewModel {

    let errorSubject = ErrorTracker()
    let loading = ActivityIndicator()
    let disposeBag = DisposeBag()

    init() {
        errorSubject.asObservable().subscribe(on: MainScheduler.instance).subscribe(onNext: { error in
            logger.debug(error.localizedDescription)
        }).disposed(by: disposeBag)
    }

    deinit {
        logger.debug("\(type(of: self)): Deinited")
    }
}

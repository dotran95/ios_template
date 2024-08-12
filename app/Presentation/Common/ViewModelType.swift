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
        errorSubject.asObservable().subscribe(on: MainScheduler.instance).subscribe(onNext: { err in
            log.debug(err.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    deinit {
        log.debug("\(type(of: self)): Deinited")
    }
}

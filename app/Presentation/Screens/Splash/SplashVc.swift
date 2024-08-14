//
//  SplashVc.swift
//  app
//
//  Created by dotn on 9/8/24.
//

import UIKit
import RxCocoa
import RxSwift

class SplashVc: ViewController {

    @IBOutlet weak var userNameLbl: UILabel!

    override func loadView() {
        super.loadView()
        let datasource = RemoteDataSourceImpl()
        let repo = UserRepositoryImpl(remoteDataSource: datasource)
        let usecase = GetUserUsecaseImpl(repository: repo)
        viewModel = SplashViewModel(userUsecase: usecase)
    }

    override func bindViewModel() {
        super.bindViewModel()
        guard let vm = viewModel as? SplashViewModel else {
            return
        }
        userNameLbl.text = "Loading..."

        let output = vm.transform(input: SplashViewModel.Input())
        output.loggedIn
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                Application.shared.presentInitialScreen()
            }).disposed(by: disposebag)

    }
}

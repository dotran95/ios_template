//
//  HomeVc.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVc: TableViewController<HomeViewModel> {

    @IBOutlet weak private var usernameLbl: UILabel!
    @IBOutlet weak private var logoutButton: UIButton!

    override func makeUI() {
        super.makeUI()
        let firstName = AuthManager.shared.userInfo?.firstName ?? ""

        "user_name".localized
            .map({ String(format: $0, firstName) })
            .drive(usernameLbl.rx.text)
            .disposed(by: disposebag)

        tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
    }

    override func bindViewModel() {
        super.bindViewModel()

        guard let vm = viewModel else {
            return
        }

        let input = HomeViewModel.Input(viewDidLoad: Driver<Void>.just(()))

        let output = vm.transform(input: input)
        output.items.drive(tableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) { (_ , obj, cell) in
            cell.titleLbl.text = obj.title
            cell.postIdLbl.text = String(describing: obj.id)
            cell.tagsLbl.text = (obj.tags ?? []).joined(separator: ", ")
        }
        .disposed(by: disposebag)

        logoutButton.rx.tap.subscribe { _ in
            Application.shared.onLogout()
        }.disposed(by: disposebag)
    }

}

//
//  TableViewController.swift
//  app
//
//  Created by VTIT on 19/8/24.
//

import RxCocoa
import UIKit
import SnapKit

class TableViewController<T: ViewModelType>: ViewController<T> {

    enum FetchEvent { case begin, completed }

    let pullToRefressObs = PublishRelay<FetchEvent>()
    var tableView = UITableView()

    override func makeUI() {
        super.makeUI()
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
}

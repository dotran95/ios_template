//
//  ViewController.swift
//  app
//
//  Created by dotn on 9/8/24.
//

import UIKit
import RxSwift
import Toast_Swift
import SVProgressHUD

protocol ViewProtocol {
    func makeUI()
    func updateUI()
}

class ViewController: UIViewController, ViewProtocol {
    
    // MARK: Properties
    
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    var viewModel: (any ViewModelType)?
    let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        bindViewModel()
        
        guard let vm = viewModel as? ViewModel else {
            return
        }
        
        vm.errorSubject.asObservable().subscribe (onNext: { [weak self] error in
            self?.view.makeToast(error.localizedDescription, duration: 2, position: .bottom)
        }).disposed(by: disposebag)
        
        vm.loading.asDriver()
            .drive(SVProgressHUD.rx.isAnimating)
            .disposed(by: disposebag)
    }
    
    func makeUI() { }
    
    func updateUI() { }
    
    func bindViewModel() { }
    
    deinit {
#if DEBUG
        log.verbose("DEINIT: \(self.className)")
#endif
    }
}

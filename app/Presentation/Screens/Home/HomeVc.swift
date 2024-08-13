//
//  HomeVc.swift
//  app
//
//  Created by dotn on 12/8/24.
//

import UIKit
import RxSwift

class HomeVc: ViewController {
    
    @IBOutlet weak private var usernameLbl: UILabel!
    @IBOutlet weak private var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func makeUI() {
        super.makeUI()
        let firstName = AuthManager.shared.user?.firstName ?? ""
        let lastName = AuthManager.shared.user?.lastName ?? ""
        
        LanguageManager.shared.localized("user_name", args: [firstName]).drive(usernameLbl.rx.text).disposed(by: disposebag)
        
        logoutButton.rx.tap.subscribe { _ in
            Application.shared.onLogout()
        }.disposed(by: disposebag)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
}

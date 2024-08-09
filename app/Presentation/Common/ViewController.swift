//
//  ViewController.swift
//  app
//
//  Created by VTIT on 9/8/24.
//

import UIKit

protocol ViewProtocol {
    func makeUI()
    func updateUI()
}

class ViewController: UIViewController, ViewProtocol {
    
    var viewModel: (any ViewModelType)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI() { }
    
    func updateUI() { }
    
    func bindViewModel() { }
}

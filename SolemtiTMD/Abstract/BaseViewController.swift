//
//  BaseViewController.swift
//  TheMovie
//
//  Created by gerardo.nuno on 08/04/22.
//

import UIKit

class BaseViewController<T>: UIViewController {

    private(set) var viewModel: T
    
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBar()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = Colors.appBarTintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.appBarTextTintColor]
        self.navigationController?.navigationBar.tintColor = Colors.appBarTextTintColor
        
    }
    
    func setupUI(){}
    func configure(viewModel: T) {}
}

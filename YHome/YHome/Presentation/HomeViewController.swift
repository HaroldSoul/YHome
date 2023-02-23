//
//  MainViewController.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var homeRepository = HomeRepository()
    
    private var mainView : HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

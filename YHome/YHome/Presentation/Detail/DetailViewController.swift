//
//  DetailViewController.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit
import ReactorKit

class DetailViewController: UIViewController, View {
    typealias Reactor = DetailReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    init(reactor: DetailReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var mainView: DetailView {
        return view as! DetailView
    }
    
    override func loadView() {
        view = DetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func bind(reactor: DetailReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
        
    }
    
    private func bindAction(reactor: DetailReactor){
        
    }
    
    private func bindState(reactor: DetailReactor){
        reactor.state
            .map{ $0.recommand }
            .bind{ [weak self] item in
                self?.bind(item)
            }.disposed(by: disposeBag)
        
    }
    
    private func bind(_ model: ReCommandReactor?) {
        guard let model = model?.currentState.recommand else {
            return
        }
        navigationItem.title = model.displayName
        mainView.bind(model)
    }

}

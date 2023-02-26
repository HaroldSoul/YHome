//
//  MainViewController.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController, View {
    
    typealias Reactor = HomeReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let keyboardWillShow = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
    private let keyboardWillHide = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
    
    init(reactor: HomeReactor){
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var mainView : HomeView {
        return view as! HomeView
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reactor?.action.onNext(.fetch)
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func initTableView(){
        mainView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private var dataSource: RxTableViewSectionedReloadDataSource<HomeSection> {
        let dataSource = RxTableViewSectionedReloadDataSource<HomeSection> { dataSource, tableView, indexPath, item -> UITableViewCell in
            switch item {
            case .tv(let tv):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TvCell.identifier,
                                                               for: indexPath) as? TvCell else {
                    return UITableViewCell()
                }
                cell.reactor = tv
                return cell
            case .newEvent(let recommand), .recommand(let recommand):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier,
                                                               for: indexPath) as? EventCell else {
                    return UITableViewCell()
                }
                cell.reactor = recommand
                return cell
            }
        }
        
        return dataSource
    }
    
}

extension HomeViewController {
    
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    private func bindAction(reactor: HomeReactor) {
        mainView.tableView.rx
            .modelSelected(ItemReactor.self)
            .bind{ [weak self] selectedItem in
                self?.moveDetail(selectedItem)
            }.disposed(by: disposeBag)
        
        keyboardWillShow
            .compactMap { $0.userInfo }
            .map { userInfo -> CGFloat in
                return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }
            .subscribe(onNext: { [weak self] height in
                self?.keyboardHeight(height: height)
            })
            .disposed(by: disposeBag)
        
        keyboardWillHide
            .compactMap{ $0.userInfo }
            .map { userInfo -> CGFloat in
                return (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
            }.subscribe(onNext: { [weak self] height in
                self?.keyboardHeight(height: 0)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindState(reactor: HomeReactor) {
        
        reactor.state
            .map{ $0.alertMessage }
            .bind{ [weak self] message in
                self?.alertMessage(message)
            }.disposed(by: disposeBag)
        
        reactor.state
            .map{ $0.result }
            .bind(to: mainView.tableView.rx
                .items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    private func alertMessage(_ message: String) {
        guard message.isEmpty == false else {
            return
        }
        let alert = UIAlertController(title: nil,
                                      message: message,
                                      preferredStyle: .alert)
        self.present(alert, animated: true,completion: nil)
    }
    
    private func moveDetail(_ selectedItem: ItemReactor) {
        switch selectedItem {
        case .recommand(let item), .newEvent(let item):
            let detailViewController = DetailViewController(reactor: DetailReactor(recommand: item))
            navigationController?.pushViewController(detailViewController,
                                                     animated: true)
        case .tv(_): return
        }
    }
    
    private func keyboardHeight(height: CGFloat) {
        let contentInsets = UIEdgeInsets(top: 0.0,
                                         left: 0.0,
                                         bottom: height,
                                         right: 0.0)
        mainView.tableView.contentInset = contentInsets
        mainView.tableView.scrollIndicatorInsets = contentInsets
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeader.identifier) as? HomeHeader,
              let headerItem = reactor?.currentState.result[section] else {
            return nil
        }
        header.model = headerItem
        return header
    }
    
    
}

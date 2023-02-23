//
//  HomeView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/23.
//

import UIKit

import FlexLayout
import PinLayout
import Then

final class HomeView: BaseView {
    
    enum Constants {
        enum Sizes {
            static let ivMainIconSize: CGSize = CGSize(width: 24,
                                                       height: 24)
            static let btnSearchSize: CGSize = CGSize(width: 24,
                                                      height: 24)
            static let textFieldHeight: CGFloat = 32
        }
        
        enum Margins {
            static let controlMargin: CGFloat = 8
            static let controlPadding: CGFloat = 8
        }
    }
    
    var rootView: UIView = UIView()
    
    
    let ivMainIcon: UIImageView = UIImageView()
    let textFieldsearch: UITextField = UITextField()
    let btnSearch: UIButton = UIButton()
    
    
    let tableView: UITableView = UITableView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(rootView)
        
        let searchView: UIView = UIView()
        
        searchView.flex
            .direction(.row)
            .alignItems(.center)
            .backgroundColor(.blue)
            .padding(Constants.Margins.controlPadding)
            .define{ flex in
                flex.addItem(ivMainIcon)
                    .size(Constants.Sizes.ivMainIconSize)
                flex.addItem(textFieldsearch)
                    .height(Constants.Sizes.textFieldHeight)
                    .marginHorizontal(Constants.Margins.controlMargin)
                    .grow(1)
                flex.addItem(btnSearch)
                    .size(Constants.Sizes.btnSearchSize)
            }
        
        
        
        rootView.flex
            .direction(.column)
            .define{ flex in
                flex.addItem(searchView)
                flex.addItem(tableView)
                    .marginTop(Constants.Margins.controlMargin)
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

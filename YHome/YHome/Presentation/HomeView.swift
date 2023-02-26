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
        enum Size {
            static let ivMainIconSize: CGSize = CGSize(width: 32,
                                                       height: 32)
            static let btnSearchSize: CGSize = CGSize(width: 24,
                                                      height: 24)
            static let textFieldHeight: CGFloat = 32
            static let searchViewHeight: CGFloat = 44
            static let lineHeight: CGFloat = 2
        }
        
        enum Margins {
            static let controlMargin: CGFloat = 8
            static let controlPadding: CGFloat = 8
            static let controlVerticalMargin: CGFloat = 4
        }
        
        enum Strings {
            static let searchPlaceHolder: String = "피부시술을 검색해 보세요.:)"
        }
        
        enum Images {
            static let searchImage: UIImage? = UIImage(named: "search")?.withColor(SystemConstants.Color.systemDefaultPinkColor)
        }
    }
    
    var rootView: UIView = UIView()
    let ivMainIcon: UIImageView = UIImageView(frame: CGRect(origin: .zero,
                                                            size: Constants.Size.ivMainIconSize)).then{
        $0.backgroundColor = .gray
        $0.round()
    }
    let searchField: UITextField = UITextField().then{
        $0.placeholder = Constants.Strings.searchPlaceHolder
    }
    let btnSearch: UIButton = UIButton().then{
        $0.setImage(Constants.Images.searchImage, for: .normal)
    }
    
    
    let tableView: UITableView = UITableView(frame: .zero,
                                             style: .grouped).then{
        $0.register(EventCell.self,
                    forCellReuseIdentifier: EventCell.identifier)
        $0.register(TvCell.self,
                    forCellReuseIdentifier: TvCell.identifier)
        $0.register(HomeHeader.self,
                    forHeaderFooterViewReuseIdentifier: HomeHeader.identifier)
        
        $0.backgroundColor = .clear
        $0.separatorInset = .zero
        $0.separatorStyle = .none
        $0.keyboardDismissMode = .interactive
    }
    
    override func setLayout() {
        super.setLayout()
        backgroundColor = .white
        addSubview(rootView)
        
        let searchView: UIView = UIView()
        
        searchView.flex
            .direction(.row)
            .alignItems(.center)
            .width(100%)
            .define{ flex in
                flex.addItem(ivMainIcon)
                    .size(Constants.Size.ivMainIconSize)
                
                flex.addItem()
                    .direction(.column)
                    .justifyContent(.end)
                    .grow(1)
                    .marginLeft(Constants.Margins.controlMargin)
                    .define{ column in
                        column.addItem()
                            .direction(.row)
                            .define{ row in
                                row.addItem(searchField)
                                    .grow(1)
                                row.addItem(btnSearch)
                                    .size(Constants.Size.btnSearchSize)
                                    .marginLeft(Constants.Margins.controlMargin)
                            }
                        column.addItem()
                            .backgroundColor(SystemConstants.Color.systemDefaultPinkColor)
                            .height(Constants.Size.lineHeight)
                            .marginTop(Constants.Margins.controlVerticalMargin)
                        
                    }
            }
        
        rootView.flex
            .direction(.column)
            .paddingHorizontal(Constants.Margins.controlMargin)
            .define{ flex in
                flex.addItem(searchView)
                    .height(Constants.Size.searchViewHeight)
                flex.addItem(tableView)
                    .marginTop(Constants.Margins.controlMargin)
                    .grow(1)
            }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootView.pin.all(pin.safeArea)
        rootView.flex.layout()
    }
}

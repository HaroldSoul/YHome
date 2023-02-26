//
//  HomeHeader.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit
import FlexLayout
import PinLayout
import Then

final class HomeHeader: BaseTableHeaderView<HomeSection> {
    static let identifier = String(describing: HomeHeader.self)
    
    enum Constants {
        enum Color {
            static let moreButtonColor: UIColor = .gray
            static let keywordColor: UIColor = .systemPink
            static let lineColor: UIColor = .black
        }
        
        enum Font {
            static let titleFont: UIFont = .boldSystemFont(ofSize: Size.nameFontSize)
            static let moreFont: UIFont = .boldSystemFont(ofSize: Size.moreFontSize)
        }
        
        enum Margins {
            static let cellPadding: CGFloat = 8
            static let viewMargin: CGFloat = 16
        }
        
        enum Size {
            static let nameFontSize: CGFloat = 18
            static let moreFontSize: CGFloat = 12
            static let headerHeight: CGFloat = 48
            static let lineHeight: CGFloat = 2
        }
        
        enum Strings {
            static let moreTitle: String = "더보기"
        }
    }
    
    private var rootView: UIView = UIView()
    
    private let lbTitle: UILabel = UILabel().then {
        $0.font = Constants.Font.titleFont
    }
    
    private let lbKeyword: UILabel = UILabel().then {
        $0.font = Constants.Font.titleFont
        $0.textColor = Constants.Color.keywordColor
    }
    private let btnMore: UIButton = UIButton().then {
        $0.setTitle(Constants.Strings.moreTitle,
                    for: .normal)
        $0.setTitleColor(Constants.Color.moreButtonColor,
                         for: .normal)
        $0.titleLabel?.font = Constants.Font.moreFont
    }
    private let lineView: UIView = UIView().then{
        $0.backgroundColor = Constants.Color.lineColor
    }
    
    override func setLayout(){
        contentView.addSubview(rootView)
        contentView.backgroundColor = .clear
        let bodyView: UIView = UIView()
        
        bodyView.flex
            .direction(.row)
            .paddingHorizontal(Constants.Margins.cellPadding)
            .define{ flex in
                flex.addItem(lbTitle)
                flex.addItem(lbKeyword)
                    .grow(1)
                flex.addItem(btnMore)
            }
        
        rootView.flex
            .direction(.column)
            .justifyContent(.center)
            .height(Constants.Size.headerHeight)
            .define{ flex in
                flex.addItem(bodyView)
                flex.addItem(lineView)
                    .height(Constants.Size.lineHeight)
                    .marginTop(Constants.Margins.viewMargin)
            }
    }

    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.pin.width(size.width)
        contentView.flex.layout(mode: .adjustHeight)
        return contentView.frame.size
    }
    
    override func bind(_ model: HomeSection) {
        lbTitle.text = model.title
        lbKeyword.text = model.keyword
        
        lbTitle.flex.markDirty()
        lbKeyword.flex.markDirty()
        
        btnMore.flex.display(model.isMore ? .flex : .none)
        lineView.flex.display(model.isMore ? .none : .flex)
    }
    
}

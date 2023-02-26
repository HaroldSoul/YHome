//
//  DetailView.swift
//  YHome
//
//  Created by kangho lee on 2023/02/26.
//

import UIKit

import Kingfisher
import FlexLayout

final class DetailView: BaseView {
    
    enum Constants {
        
        enum Color {
            static let displayNameColor: UIColor = .darkGray
            static let nameColor: UIColor = .black
            static let commentColor: UIColor = .gray
            static let subContentColor: UIColor = displayNameColor
            static let countColor: UIColor = .systemPink
            static let reservationColor: UIColor = SystemConstants.Color.systemDefaultPinkColor
        }
        
        enum Font {
            static let displayNameFont: UIFont = .boldSystemFont(ofSize: Size.displayNameSize)
            static let priceFont: UIFont = .boldSystemFont(ofSize: Size.priceSize)
            
        }
        
        enum Size {
            static let displayNameSize: CGFloat = 18
            static let priceSize: CGFloat = 24
        }
        
        enum Margins {
            static let cellPadding: CGFloat = 8
            static let viewMargin: CGFloat = 8
            static let controlMargin: CGFloat = 4
        }
        enum images {
            static let placeHolder: UIImage? = UIImage(named: "placeholder")
        }
    }
    
    private let rootView: UIView = UIView()
    private let ivThumbNail: UIImageView = UIImageView()
    private let lbHospitalName: UILabel = UILabel().then{
        $0.font = Constants.Font.displayNameFont
    }
    private let lbTitle: UILabel = UILabel()
    private let lbDescription: UILabel = UILabel().then{
        $0.numberOfLines = 0
    }
    private let lbPrice:UILabel = UILabel().then{
        $0.font = Constants.Font.priceFont
        $0.textColor = SystemConstants.Color.systemDefaultPinkColor
    }
    private let scrollView: UIScrollView = UIScrollView()
    
    override func setLayout() {
        super.setLayout()
        addSubview(scrollView)
        
        backgroundColor = .white
        
        rootView.flex
            .direction(.column)
            .define{ flex in
                flex.addItem(ivThumbNail)
                    .height(60%)
                flex.addItem()
                    .direction(.column)
                    .marginVertical(Constants.Margins.viewMargin)
                    .padding(Constants.Margins.viewMargin)
                    .define{ inner in
                        inner.addItem(lbHospitalName)
                            .marginVertical(Constants.Margins.controlMargin)
                        inner.addItem(lbTitle)
                        inner.addItem(lbDescription)
                            .marginVertical(Constants.Margins.controlMargin)
                        inner.addItem(lbPrice)
                            .marginVertical(Constants.Margins.controlMargin)
                        
                    }
            }
        
        scrollView.addSubview(rootView)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all(pin.safeArea)
        scrollView.flex.layout()
        rootView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootView.frame.size
        
    }
    
    func bind(_ recommand: RecommendEvent) {
        if let imageURL = URL(string: recommand.thumbnailImageUrl) {
            ivThumbNail.kf.setImage(with: imageURL, placeholder: SystemConstants.images.placeHolder)
        }
        lbHospitalName.text = String(format: "🏥 %@", recommand.displayName)
        lbTitle.text = recommand.name
        lbDescription.text = recommand.comment
        lbPrice.text = String(format: "%d %@", recommand.price, recommand.currencyName)
        
    }
    
    
}
